EXAMPLE_APP_DIR="$BATS_TMPDIR/example app"
TEST_BASENAME="$(basename $BATS_TEST_DIRNAME)"
PLUGIN_ROOT="${BATS_TEST_DIRNAME%${TEST_BASENAME}}"

setup() {
  export RENV_ROOT="$BATS_TMPDIR/Renv_root"
  mkdir -p "$RENV_ROOT/plugins"
  ln -s "$PLUGIN_ROOT" "$RENV_ROOT/plugins/rbundler-R-version"
}

teardown() {
  rm -r "$EXAMPLE_APP_DIR"
  rm -r "$RENV_ROOT"
}

assert() {
  if ! "$@"; then
    flunk "failed: $@"
  fi
}

assert_equal() {
  if [ "$1" != "$2" ]; then
    { echo "expected: $1"
      echo "actual:   $2"
    } | flunk
  fi
}

assert_output() {
  local expected
  if [ $# -eq 0 ]; then expected="$(cat -)"
  else expected="$1"
  fi
  assert_equal "$expected" "$output"
}

assert_success() {
  if [ "$status" -ne 0 ]; then
    flunk "command failed with exit status $status"
  elif [ "$#" -gt 0 ]; then
    assert_output "$1"
  fi
}

# cd_into_project_with_description R_version [extra_args]
cd_into_project_with_description() {
  mkdir -p "$EXAMPLE_APP_DIR"
  cd "$EXAMPLE_APP_DIR"
  echo "    R (>= ${1}),${2}" > "$EXAMPLE_APP_DIR/DESCRIPTION"
}

# Creates fake version directory
create_version() {
  d="$RENV_ROOT/versions/$1/bin"
  mkdir -p "$d"
  ln -s /bin/echo "$d/R"
}

flunk() {
  { if [ "$#" -eq 0 ]; then cat -
    else echo "$@"
    fi
  } >&2
  return 1
}
