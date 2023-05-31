if [ -n "$CUDA_HOME" ]; then
    export PATH="$PATH:$CUDA_HOME/bin"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$CUDA_HOME/lib64"
fi
