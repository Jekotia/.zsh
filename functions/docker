#! /bin/bash
docker() {
    if [[ $@ == "ps" ]]; then
        command docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" | more
    else
        command docker "$@"
    fi
}
