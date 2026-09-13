if ! command -v clang &> /dev/null && [ -z "$LLVM_HOME" ]; then
    for __llvm_lib_dir in $(printf "%s\n" /usr/lib/llvm-* 2>/dev/null | sort -r -n -t '-' -k 2); do
        [ -d "$__llvm_lib_dir" ] || continue
        export LLVM_HOME="$__llvm_lib_dir"
        break
    done
    unset __llvm_lib_dir
fi

if [ -n "$LLVM_HOME" ]; then
    export PATH=$PATH:$LLVM_HOME/bin
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$LLVM_HOME/lib
fi
