#!/bin/bash

if [ $# -eq 0 -o $# -gt 1 ]; then
    echo "Usage: $(basename $0) file.tql.gz"
    exit 1
fi

FILE=$(realpath "$1")
DIR=$( cd "$( dirname "$0" )" && pwd )
COMMAND=/tmp/temp_command.isql

echo $FILE
echo $DIR

echo "log_enable(2);" > $COMMAND
echo "ttlp(gz_file_open('$FILE'), '', 'http://www.newsreader-project.eu/instances', 736);" >> $COMMAND
echo "checkpoint;" >> $COMMAND
#added to be sure checkpoint is executed
echo "status();" >> $COMMAND

#cat $COMMAND

echo "running /data/software/virtuoso/bin/isql-vt localhost:9051 dba dba $COMMAND"
/data/software/virtuoso/bin/isql-vt localhost:9051 dba dba /tmp/temp_command.isql
echo "running supervisorctl restart ksdemo-v"
supervisorctl restart ksdemo-v
