# Honors Project 2016-2017
This repository contains information relevant to Eric Bell's Honors in Biochemistry project.  Please understand that the scripts found here are meant for reference and not to work as is; many of them include references to other scripts or specific folders/files that will not be found in their current condition.  All scripts are organized by their language, with extra input and output files being stored in "data".

## Repository Contents

+ **Bash**
  * **fetchlib.sh** fetches tar files from the sciurus server and decompresses them
  * **procres.sh** processes results of a segment of the ZINC library
  * **sort.sh** finds each result file of a segment of the ZINC library and sorts them based on predicted binding affinity
+ **Data**
  * **apres.txt** is a results file of the fingerprinting regression using atom pairs
  * **conf.txt** is a parameter file used to run AutoDock Vina
  * **dP2.pdb** is a structure file containing the delta-P2 structure of SurA from the PDB
  * **dP2.pdbqt** is **dP2.pdb** converted into the filetype accepted by AutoDock Vina
  * **final.txt** is a sorted results file produced by **sort.sh**
  * **job.index** is a list of jobs to be run in an array, produced by Raccoon2
  * **reflist.txt** is the list of ZINC library segments to be run through **genres.py**
  * **res.txt**
  