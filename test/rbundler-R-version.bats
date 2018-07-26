#!/usr/bin/env bats

load test_helper

@test 'Allow overriding version with Renv local' {
  cd_into_project_with_description 1.2.3
  create_version 4.5.6
  Renv local 4.5.6
  run Renv rbundler-R-version
  assert_success ''
}

@test 'Recognize simple R version in a line beginning Depends:' {
  mkdir -p "$EXAMPLE_APP_DIR"
  cd "$EXAMPLE_APP_DIR"
  echo "Depends: R (>= 1.2.3)," > "$EXAMPLE_APP_DIR/DESCRIPTION"
  run Renv rbundler-R-version
  assert_success '1.2.3'
}

@test 'Recognize simple R version in a line with an indent' {
  cd_into_project_with_description 1.2.3
  run Renv rbundler-R-version
  assert_success '1.2.3'
}
