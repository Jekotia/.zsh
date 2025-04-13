#! /usr/bin/env bash
#alias ncdu='ncdu -x -e -r --exclude-kernfs --confirm-quit -2'
alias ncdu='ncdu -x -e --exclude-kernfs --confirm-quit -2'

# ncdu <options> <directory>
#   -h,--help                  This help message
#   -q                         Quiet mode, refresh interval 2 seconds
#   -v,-V,--version            Print version
#   -x                         Same filesystem
#   -e                         Enable extended information
#   -r                         Read only
#   -o FILE                    Export scanned directory to FILE
#   -f FILE                    Import scanned directory from FILE
#   -0,-1,-2                   UI to use when scanning (0=none,2=full ncurses)
#   --si                       Use base 10 (SI) prefixes instead of base 2
#   --exclude PATTERN          Exclude files that match PATTERN
#   -X, --exclude-from FILE    Exclude files that match any pattern in FILE
#   -L, --follow-symlinks      Follow symbolic links (excluding directories)
#   --exclude-caches           Exclude directories containing CACHEDIR.TAG
#   --exclude-kernfs           Exclude Linux pseudo filesystems (procfs,sysfs,cgroup,...)
#   --confirm-quit             Confirm quitting ncdu
#   --color SCHEME             Set color scheme (off/dark)
