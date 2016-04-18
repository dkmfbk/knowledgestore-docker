#!/bin/bash

if [ $# -eq 0 -o $# -gt 2 ]; then
    echo "Usage: $(basename $0) in-file(s) outfile"
    echo "       where in-file is one or more RDF files, event gzipped, in any supported RDF format (wildcard '*' can be used)"
    echo "       where outfile is one RDF, deduplicated, file merging all the in-file(s), , in any supported RDF format (e.g., output.tql.gz)"
    echo " "
    echo "example usage: $(basename $0) '*.trig' all.tql.gz"
    echo "               if you use wildcards, encapsulate within '' as in the example"
    exit 1
fi

INPUT=$1
OUTPUT=$(realpath "$2")

/data/software/rdfpro/rdfpro @read $INPUT @unique @write $OUTPUT




