# Global retry utility for Docker builds
# This file is intended to be sourced by other scripts
retry() {
    local n=1
    local max=3
    local delay=2
    while true; do
        "$@" && break || {
            if [[ $n -lt $max ]]; then
                ((n++))
                echo "Command failed. Attempt $n/$max in ${delay}s..."
                sleep $delay
            else
                echo "The command has failed after $n attempts."
                return 1
            fi
        }
    done
}
