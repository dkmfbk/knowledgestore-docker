#!/bin/bash

if [ $# -eq 0 -o $# -gt 1 ]; then
    echo "Usage: $(basename $0) path"
    echo "       where path is a directory containing NAF files"
    exit 1
fi

NAFPATH=$(realpath "$1")

#additional parameter can be added for parallel population such as: -b 10 -qs 10 -ct 10 -ksm 1
echo "time /data/software/knowledgestore/bin/ksnaf.sh -u http://localhost:9053/ -r -d $NAFPATH"
(cd /data/software/knowledgestore/bin && ./ksnaf.sh -u http://localhost:9053/ -r -d $NAFPATH)

echo "running supervisorctl restart ksdemo-v"
supervisorctl restart ksdemo-v
