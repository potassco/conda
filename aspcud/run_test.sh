aspcud --version
aspcud --help
cat <<EOF
package: a
version: 1
conflicts: a , b
provides: b

package: c
conflicts: c
version: 1
depends: b

request: 
install: c
EOF
aspcud test.cudf