convert_version() {
    # https://qiita.com/gomaaa/items/70f6d25611fb6b3dc1a5
    echo $1 | (IFS=. read -r major minor micro
	       printf "%02d%02d%02d" ${major} ${minor} ${micro})
}

revert_version() {
    printf '%d.%d.%d' $((10#${1:0:2})) $((10#${1:2:2})) $((10#${1:4:2}))
}

RENV_RBUNDLER_VERSION=$(Renv-rbundler-R-version)

if [ -n "$RENV_RBUNDLER_VERSION" ]; then

    rbundler_version=$(convert_version "$RENV_RBUNDLER_VERSION")

    renv_versions=()
    for path in "${RENV_ROOT}/versions/"*; do
    	if [ -d "${path}" ]; then
    	    ver=$(convert_version "${path##*/}")
    	    if [ "${ver}" -ge "${rbundler_version}" ]; then
    	    	renv_versions+=( "${ver}" )
    	    fi
    	fi
    done
    IFS=$'\n' renv_versions=($(sort -r <<<"${renv_versions[*]}")); unset IFS

    if [ -n "${#renv_versions[@]}" ]; then
	RENV_VERSION=$(revert_version "${renv_versions[0]}")
    fi
    
fi
