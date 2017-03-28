#!/bin/sh

# Add namespace support
# A script that create schema for app auit.
test -n "$HBASE_HOME" || {
    echo >&2 'The environment variable HBASE_HOME must be set.'
    exit 1
}

test -d "$HBASE_HOME" || {
    echo >&2 "No such direcory: HBASE_HOME=$HBASE_HOME"
    exit 1
}

MDM_NS=${MDM_NS-'test'}
t="${MDM_NS}:t"

exec "$HBASE_HOME/bin/hbase" shell <<EOF
    disable '$t'
	
    drop '$t'

    create '$t',{
        NAME => 'cf', VERSIONS => 1
    }

EOF
