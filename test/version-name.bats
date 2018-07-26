#!/usr/bin/env bats

load test_helper

@test 'version-name continues to report default version if no DESCRIPTION' {
  run Renv version-name
  assert_success "system"
}

@test 'check version-name hook' {
    run Renv hooks version-name
    assert_success "${BATS_TMPDIR}/Renv_root/plugins/rbundler-R-version/etc/Renv.d/version-name/rbundler-R-version.bash"
}

@test 'version-name recognizes R version in DESCRIPTION' {
  create_version 1.8.7
  cd_into_project_with_description 1.8.7
  run Renv version-name
  assert_success "1.8.7"
}
