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

	put '$t', 'row1', 'cf:a', 'value1'
	put '$t', 'row2', 'cf:b', 'value2'
	put '$t', 'row3', 'cf:c', 'value3'
	put '$t', 'row4', 'cf:d', 'value4'
	scan '$t'
EOF
