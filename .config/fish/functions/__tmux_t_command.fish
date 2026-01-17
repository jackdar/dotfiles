function __tmux_t_command
    set --local name (path basename $PWD)
    echo "tmux new-session -A -s $name"
end
