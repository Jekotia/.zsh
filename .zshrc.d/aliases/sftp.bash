#! /usr/bin/env bash

# Prevent execution of configured SSH RemoteCommand
alias sftp="sftp -o 'RemoteCommand none'"