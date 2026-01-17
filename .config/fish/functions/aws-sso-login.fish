function aws-sso-login --description 'AWS SSO login wrapper that updates status cache'
    # Call the actual aws sso login command
    command aws sso login $argv
    set -l exit_code $status

    # If login was successful, update the cache
    if test $exit_code -eq 0
        set -l profile $AWS_PROFILE
        test -z "$profile" && set profile $AWS_DEFAULT_PROFILE

        if test -n "$profile"
            set -l cache_file /tmp/aws_sso_status_(id -u)_$profile
            echo -n '● ' > $cache_file
        end
    end

    return $exit_code
end
