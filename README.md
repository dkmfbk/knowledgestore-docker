Readme.md

** READ CAREFULLY BEFORE STARTING **

Download the whole content of this directory.

To build the KnowledgeStore container, simply run ./build_ks_container.sh.
This will create a Docker image named "ks". 

Before running the Docker container, you can decided to download some additional files to pre-populate / test the running KS instance:
- DBpedia 2015.4 (size: 1.3Gb): wget "http://knowledgestore.fbk.eu/files/vm/dbpedia2015en_allForKS.tql.gz"
- ESO v2.0 (size: 40Kb) : wget "http://knowledgestore.fbk.eu/files/vm/ESO_v2_all_forKS.tql.gz"
We suggest to move this files in the _data/additional_data_ subfolder.


