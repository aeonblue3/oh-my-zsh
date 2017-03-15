if [[ "$OSTYPE" == linux* ]]; then
    local _vscode_path > /dev/null 2>&1
    _vscode_path=$(which code)

    if [[ -a $_vscode_path ]]; then
        vsc_run() { $_vscode_path $@ >/dev/null 2>&1 &| }
        alias vsc=vsc_run
        break
    fi

elif  [[ "$OSTYPE" = darwin* ]]; then
    local _sublime_darwin_paths > /dev/null 2>&1
    _sublime_darwin_paths=(
        "/Applications/Visual Studio Code.app"
        "$HOME/Applications/Visual Studio Code.app"
    )
    for _vscode_path in $_sublime_darwin_paths; do
        if [[ -a $_vscode_path ]]; then
            code () { open $* -a "$_vscode_path" }
            alias vsc=code
            break
        fi
    done

elif [[ "$OSTYPE" = 'cygwin' ]]; then
    local _vscode_cygwin_paths > /dev/null 2>&1
    _vscode_cygwin_paths=(
        "$(cygpath $ProgramW6432/Microsoft\ VS\ Code)/Code.exe"
        "$(cygpath $ProgramFiles(x86)/Microsoft\ VS\ Code)/Code.exe"
    )
    for _vscode_path in $_vscode_cygwin_paths; do
        if [[ -a $_vscode_path ]]; then
            code () { "$_vscode_path" $* }
            alias vsc=code
            break
        fi
    done

fi

