# Honors Project 2016-2017
This repository contains information relevant to Eric Bell's Honors in Biochemistry project.  Please understand that the scripts found here are meant for reference and not to work as is; many of them include references to other scripts or specific folders/files that will not be found in their current condition.  All scripts are organized by their language, with extra input and output files being stored in "data".

## Repository Contents

+ **Bash**
  * **assemblefpt.sh** creates an aggregate .fpt structure file from the molecules specified in a res-like file
  * **assemblesdf.sh** creates an aggregate .sdf structure file from the molecules specified in a res-like file
  * **fetchlib.sh** fetches tar files from the sciurus server and decompresses them
  * **procres.sh** processes results of a segment of the ZINC library
  * **sort.sh** finds each result file of a segment of the ZINC library and sorts them based on predicted binding affinity
  * **unzipper.sh** processes the .sdf.gz files taken from the ZINC library and turns them into zipped directories (.tar.gz)
  * **usual.sdf.gz** is the script provided by ZINC to download every segment of the "Drugs Now" subset of the ZINC12 library
+ **Data**
  * **apres.txt** is a results file of the fingerprinting regression using atom pairs
  * **conf.txt** is a parameter file used to run AutoDock Vina
  * **dP2.pdb** is a structure file containing the delta-P2 structure of SurA from the PDB
  * **dP2.pdbqt** is **dP2.pdb** converted into the filetype accepted by AutoDock Vina
  * **final.txt** is a sorted results file produced by **sort.sh**
  * **job.index** is a list of jobs to be run in an array, produced by Raccoon2
  * **reflist.txt** is the list of ZINC library segments to be run through **genres.py**
  * **res.txt** is a results file from a virtual screen.  The formatting of this file is referred to as "res-like"
  * **results.html** is a file openable in a web browser that presents information about the top hits of the virtual screen
  * **thresh.txt** is a res-like file containing all molecules above the threshold specified in **thresh.py**
+ **Python**
  * **energystats.py** calculates the mean and standard deviation of the binding affinity of any res-like file
  * **genres.py** creates **results.html** based off of the res.txt files in the directories specified by **reflist.txt**
  * **ligsort.py** sorts a res-like file and returns a user specified number of top hits (set to 1000 in **sort.sh**)
  * **procfpt.py** processes .fpt files and adds binding affinity information for use in regression
  * **randomset.py** generates random sets of molecules from an aggregate res-like file
  * **regres.py** compiles results from different regressions into one results file
  * **regress.py** runs a regression on a set of molecules specified in a .csv file
  * **thresh.py** returns all molecules from a sorted res-like file that meet a binding affinity threshold
+ **R**
  * **chemmine.R** declares every function that interfaces with ChemmineR, ChemmineOB, and fmcsR
  * **installpackages.R** installs the packages required for proper functionality of **chemmine.R**

  