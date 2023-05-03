if [ -n "$VSCODE_AGENT_FOLDER" ]; then
    export EDITOR="code --wait"
    export PDFVIEWER="code --reuse-window"
fi
