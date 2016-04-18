#!/bin/bash

if [ $# -eq 0 -o $# -gt 1 ]; then
    echo "Usage: $(basename $0) path"
    echo "       where path is a directory where to store the results"
    exit 1
fi

OUTPUT=$(realpath "$1")

echo "/data/software/newsreader-tools/ks-content-report -q /data/software/newsreader-tools/etc/KSContentReport-queries/ -o $OUTPUT -t 6000 -s http://localhost:9053"
/data/software/newsreader-tools/ks-content-report -q /data/software/newsreader-tools/etc/KSContentReport-queries/  -o $OUTPUT -t 6000 -s http://localhost:9053
/data/software/newsreader-tools/linking-analyzer -g 1 -o $OUTPUT/linking-stats.html -t 6000 -s http://localhost:9053



