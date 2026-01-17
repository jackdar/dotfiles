function _tide_item_aws
    # Check for valid AWS SSO session with the current profile
    set -l profile_arg ""
    if set -q AWS_PROFILE
        set profile_arg --profile $AWS_PROFILE
    else if set -q AWS_DEFAULT_PROFILE
        set profile_arg --profile $AWS_DEFAULT_PROFILE
    end

    # Check if any parent directory has CDK markers
    set -l current_dir $PWD
    set -l has_cdk false

    while test "$current_dir" != $HOME
        if test -d "$current_dir/.infrastructure/cdk"; or test -f "$current_dir/cdk.json"
            set has_cdk true
            break
        end
        set current_dir (dirname "$current_dir")
    end

    if test "$has_cdk" = false
        return
    end

    # AWS_PROFILE overrides AWS_DEFAULT_PROFILE, AWS_REGION overrides AWS_DEFAULT_REGION
    set -q AWS_PROFILE && set -l AWS_DEFAULT_PROFILE $AWS_PROFILE
    set -q AWS_REGION && set -l AWS_DEFAULT_REGION $AWS_REGION

    set -l short_profile (string sub -l 1 (string lower "$AWS_DEFAULT_PROFILE"))
    set -l short_region (echo "$AWS_DEFAULT_REGION" | string replace -ra '^([a-z])[a-z]*-([a-z]+)-([0-9]+)$' '$1$2$3' | string replace -a north n | string replace -a south s | string replace -a east e | string replace -a west w | string replace -a central c)

    if test -n "$short_profile" && test -n "$short_region"
        _tide_print_item aws $tide_aws_icon' ' "$short_profile/$short_region"
    else if test -n "$short_profile$short_region"
        _tide_print_item aws $tide_aws_icon' ' "$short_profile$short_region"
    end
end
