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
    
    while test "$current_dir" != "/"
        if test -d "$current_dir/.infrastructure/cdk"; or test -d "$current_dir/cdk"; or test -f "$current_dir/cdk.json"
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

    # Shorten profile names
    switch $AWS_DEFAULT_PROFILE
        case staging
            set AWS_DEFAULT_PROFILE s
        case production
            set AWS_DEFAULT_PROFILE p
    end
    
    # Shorten region names
    switch $AWS_DEFAULT_REGION
        case ap-southeast-2
            set AWS_DEFAULT_REGION ase2
        case eu-west-1
            set AWS_DEFAULT_REGION ew1
        case us-east-1
            set AWS_DEFAULT_REGION ue1
    end

    if test -n "$AWS_DEFAULT_PROFILE" && test -n "$AWS_DEFAULT_REGION"
        _tide_print_item aws $tide_aws_icon' ' "$AWS_DEFAULT_PROFILE/$AWS_DEFAULT_REGION"
    else if test -n "$AWS_DEFAULT_PROFILE$AWS_DEFAULT_REGION"
        _tide_print_item aws $tide_aws_icon' ' "$AWS_DEFAULT_PROFILE$AWS_DEFAULT_REGION"
    end
end
