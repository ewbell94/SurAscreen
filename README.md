# Repository Contents

+ **Bash**
  * **assemblefpt.sh** creates an aggregate .fpt structure file from the molecules specified in a res-like file
  * **assemblesdf.sh** creates an aggregate .sdf structure file from the molecules specified in a res-like file
  * **fetchlib.sh** fetches tar files from the sciurus server and decompresses them
  * **procres.sh** processes results of a segment of the ZINC library
  * **sort.sh** finds each result file of a segment of the ZINC library and sorts them based on predicted binding affinity
  * **unzipper.sh** processes the .sdf.gz files taken from the ZINC library and turns them into zipped directories (.tar.gz)
  * **usual.sdf.gz** is the script provided by ZINC to download every segment of the "Drugs Now" subset of the ZINC12 library
+ **Data**
  * **bottomfeat.txt** is a list of the bottom 10 features as predicted by the regression from **finalres.txt**
  * **conf.txt** is a parameter file used to run AutoDock Vina
  * **dP2.pdb** is a structure file containing the delta-P2 structure of SurA from the PDB
  * **dP2.pdbqt** is **dP2.pdb** converted into the filetype accepted by AutoDock Vina
  * **final.txt** is a sorted results file produced by **sort.sh**
  * **finalres.txt** is the scores of each feature output by the regression
  * **guide.txt** is the list of features corresponding to each bit position in the "FP4" fingerprint
  * **job.index** is a list of jobs to be run in an array, produced by Raccoon2
  * **mega.sdf** structure files for all molecules with predicted binding affinities equal to or better than -9.2 kcal/mol
  * **reflist.txt** is the list of ZINC library segments to be run through **genres.py**
  * **res.txt** is a results file from a virtual screen.  The formatting of this file is referred to as "res-like"
  * **results.html** is a file openable in a web browser that presents information about the top hits of the virtual screen
  * **SMARTS_InteLigand.txt** is the definition file of the "FP4" fingerprint protocol in OpenBabel
  * **style.css** is a stylesheet to help format **results.html**
  * **thresh.txt** is a res-like file containing all molecules above the threshold specified in **thresh.py**
  * **topfeat.txt** is a list of the top 10 features as predicted by the regression from **finalres.txt**
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

  
