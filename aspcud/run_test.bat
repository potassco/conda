aspcud --version
aspcud --help
cudf2lp --version
@(
  echo package: a
  echo version: 1
  echo conflicts: a , b
  echo provides: b
  echo.
  echo package: c
  echo conflicts: c
  echo version: 1
  echo depends: b
  echo.
  echo request: 
  echo install: c
)> test.cudf
aspcud test.cudf