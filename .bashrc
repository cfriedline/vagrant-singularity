## ad this to your .bashrc

if [ -n "${SINGULARITY_INIT}" ]; then
    export PS1="(S) $PS1"
fi
