function entdb-delete-mig
    if test (count $argv) -lt 1
        echo "Usage: entdb-delete-mig <migration_name> [database_name]"
        return 1
    end

    set migration_name $argv[1]
    if test (count $argv) -ge 2
        set database_name $argv[2]
    else
        set database_name "dev"
    end

    mysql --login-path=entdb-$database_name -e "DELETE FROM sykes_reservations.phinxlog WHERE migration_name LIKE '%$migration_name%';"
end
