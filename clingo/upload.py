#!/usr/bin/env python
import subprocess
import urllib.request
import json
import re
import os
import locale

def get_version():
    url = 'https://raw.githubusercontent.com/potassco/clingo/wip/libclingo/clingo.h'
    with urllib.request.urlopen(url) as response:
        data = response.read()
        text = data.decode(response.info().get_param('charset', 'utf-8'))

    m = next(re.finditer(r'#define CLINGO_VERSION "([0-9]*\.[0-9]*\.[0-9*])"', text))
    return m.group(1)

def get_build_number(version):
    pkgs = json.loads(subprocess.check_output(['conda', 'search', '--json', '-c', 'potassco/label/dev', 'clingo']))

    build_number = -1
    for pkg in pkgs['clingo']:
        if pkg['channel'].find('potassco/label/dev') >= 0 and pkg["version"] == version:
            build_number = max(build_number, pkg['build_number'])
            build = pkg['build_number']

    return build_number + 1

version = get_version()
build_number = get_build_number(version)

files = subprocess.check_output(['conda', 'build', '--output', '.']).decode(locale.getpreferredencoding()).splitlines()


build_env = os.environ.copy()
build_env.pop("BUILD_RELEASE", None)
build_env["VERSION_NUMBER"] = version
build_env["BUILD_NUMBER"] = str(build_number)
subprocess.call(['conda', 'build', '.'], env=build_env)

for f in files:
    subprocess.call(['anaconda', 'upload', f, '--label', 'dev'])
