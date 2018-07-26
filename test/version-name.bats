#!/usr/bin/env bats

load test_helper

@test 'version-name continues to report default version if no DESCRIPTION' {
  run Renv version-name
  assert_success "system"
}

@test 'version-name continues to report local version if no DESCRIPTION' {
    create_version 3.5.0
    Renv local 3.5.0
    run Renv version-name
    assert_success "3.5.0"
}

@test 'check version-name hook' {
    run Renv hooks version-name
    assert_success "${BATS_TMPDIR}/Renv_root/plugins/rbundler-R-version/etc/Renv.d/version-name/rbundler-R-version.bash"
}

@test 'version-name find an exact R version in DESCRIPTION' {
  create_version 1.8.7
  create_description 1.8.7
  run Renv version-name
  assert_success "1.8.7"
}

@test 'version-name find the latest R version in DESCRIPTOIN' {
    create_version 3.4.0
    create_version 3.5.0
    create_version 3.5.1
    create_version 2.15.1
    create_description 3.5.0
    run Renv version-name
    assert_success "3.5.1"
}
