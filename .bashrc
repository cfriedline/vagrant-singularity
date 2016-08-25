## ad this to your .bashrc

if [ -n "${SINGULARITY_INIT}" ]; then
    export PS1="(S) $PS1"
    export LC_CTYPE=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
fi
