if [ -d "/opt/intel" ]; then
    export PATH=$PATH:/opt/intel/bin
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/lib/intel64

    # MKL Setup
    if [ -d "/opt/intel/mkl" ]; then
        export MKLROOT="/opt/intel/mkl"
        export PATH=$PATH:$MKLROOT/bin
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MKLROOT/lib/intel64
    fi
fi
