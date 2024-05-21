#! /usr/bin/env bash
docker() {
#shellcheck disable=SC2140
docker_ps_table="{{.Names}}\t"\
"{{.State}}\t"\
"{{.RunningFor}}\t"\
"{{.Status}}\t"\
"{{.Size}}\t"\
"{{.Ports}}"

    if [[ $* == "ps" ]]; then
        command docker ps --format "table ${docker_ps_table}" | more
    else
        command docker "$@"
    fi
}
