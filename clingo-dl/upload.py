#!/usr/bin/env python
import subprocess
import urllib.request
import json
import re
import os
import locale
import sys

label = "dev"
channel = "potassco/label/dev"
package_name = "clingo-dl"
version_url = 'https://raw.githubusercontent.com/potassco/clingo-dl/wip/libclingodl/clingo-dl.h'

channels = ['-c', channel]

def get_version():
    with urllib.request.urlopen(version_url) as response:
        data = response.read()
        text = data.decode(response.info().get_param('charset', 'utf-8'))

    m = next(re.finditer(r'#define CLINGODL_VERSION "([0-9]*\.[0-9]*\.[0-9*])"', text))
    return m.group(1)

def get_build_number(version):
    pkgs = {package_name:[]}
    try:
        pkgs = json.loads(subprocess.check_output(['conda', 'search', '--json'] + channels + [package_name]))
    except subprocess.CalledProcessError as e:
        sys.stderr.write("Warning: Either project does not exist or Anaconda server is not reachable")

    build_number = -1
    for pkg in pkgs[package_name]:
        if pkg['channel'].find(channel) >= 0 and pkg["version"] == version:
            build_number = max(build_number, pkg['build_number'])
            build = pkg['build_number']

    return build_number + 1

version = get_version()
build_number = get_build_number(version)

build_env = os.environ.copy()
build_env.pop("BUILD_RELEASE", None)
build_env["VERSION_NUMBER"] = version
build_env["BUILD_NUMBER"] = str(build_number)

files = subprocess.check_output(['conda', 'build'] + channels + ['--output', '.'], env=build_env).decode(locale.getpreferredencoding()).splitlines()
assert(len(files) > 0)

subprocess.call(['conda', 'build'] + channels + ['.'], env=build_env)

for f in files:
    subprocess.call(['anaconda', 'upload', f, '--label', label])
