#!/usr/bin/env bats

load test_helper

@test 'version-origin continues to report default version if no DESCRIPTION' {
  run Renv version-origin
  assert_success "${RENV_ROOT}/version"
}

@test 'version-origin reports DESCRIPTION if set by DESCRIPTION' {
  cd_into_project_with_description 1.8.7
  run Renv version-origin
  assert_success "DESCRIPTION"
}
