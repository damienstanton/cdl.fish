function init --description "writes a template `cdl.fish` which you can edit to your liking."
    echo >cdl.fish "\
#!/usr/bin/env fish

# begin by replacing `list` with your intended command.
# new commands can be added to the `commands` array here.
set commands list

function list
    echo \"valid commands are: [\$commands]\"
end

switch \$argv[1]
    case --help -h help
        echo \"`cdl` scripts are like Makefiles, where each make directive is instead a fish function.\"
        echo \"Such functions are called `commands`. In the default `cdl.fish`, the only command is `list`, which lists available commands\"
        echo \"Try it now by typing `cdl list`.\"
    case list
        echo \"Yay! you now know how to use `cdl`. Add/modfiy commands by editing `./cdl.fish` to your liking.\"
        echo \"Now you will see the output of the `list` command:\"
        echo
        list
    case \"*\"
        echo \"`./cdl.fish` exists, but got an unknown command `\$argv`. Type `cdl --help`, or `cdl -h`, or cdl help\"
end
"
    chmod +x ./cdl.fish
    echo "🦑 Added a default ./cdl.fish. Type `cdl` again to execute it."
end

function cdl --description "a make-like build tool which executes ./cdl.fish"
    set -l cmd $argv[1]
    switch $cmd
        case rm --remove --rm -rm
            if test -e cdl.fish
                echo "🦑 Goodbye. Sorry to see you go!"
                rm ./cdl.fish && echo "🦑 ./cdl.fish has been removed."
            else
                echo "🦑 Nothing to remove."
            end
        case init --init -i
            if test -e cdl.fish
                ./cdl.fish $cmd $argv[2..-1]
            else
                init
            end
        case "*"
            if test -e cdl.fish
                ./cdl.fish $cmd $argv[2..-1]
            else
                echo "🦑 Welcome! A cdl.fish will help you automate your build tools/compiler, just like GNU make, but cuter."
                echo "🦑 A cdl.fish is a build script in your workspace. It just calls function symbols (which you define)."
                echo "🦑 Type `cdl init` to add a cdl.fish script to your current dir."
            end
    end
end
