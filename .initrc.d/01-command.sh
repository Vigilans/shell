# command.sh: put the executables under commands/ on PATH.

# A directory joins PATH when it holds any non-hidden file; the files are
# expected to carry the execute bit already.
for dir in "$SHELL_CONFIG_HOME/commands" "$SHELL_CONFIG_HOME/commands/local"; do
    for entry in "$dir"/*; do
        if [ -f "$entry" ]; then
            export PATH="$dir:$PATH"
            break
        fi
    done
done
unset dir entry
