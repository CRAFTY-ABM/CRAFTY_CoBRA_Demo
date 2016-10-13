# CRAFTY CoBRA Demonstration Model

## Configuration

The out-of-the-box configuration is:

* startTick: 2000
* endTick:	2013
* world:	NEEU (North East European Union)
* scenario:	setA
* FRs:		COF\_Cereal, NCOF\_Cereal, COF\_Livestock, NCOF\_Livestock, CConf\_Cereal, NCConf\_Cereal, CConf\_Livestock, NCConf\_Livestock, Forester
* BTs:		Pseudo, NonAdopter\_EE\_Cluster1, NonAdopter\_EE\_Cluster2, NonAdopter\_EE\_Cluster3, NonAdopter\_EE\_Cluster4, NonAdopter\_EE\_Cluster5, Adopter\_EE\_Cluster1, Adopter\_EE\_Cluster2, Adopter\_EE\_Cluster3, Adopter\_EE\_Cluster4, Adopter\_EE\_Cluster5, Adopter\_EE\_Cluster6
* Preferences: WAttitude, WSubjectiveNorm, WPBC, THRESHOLD
* Capitals:	Cprod, Fprod, Infra, Lprod, Nat, Econ
* Services:	Meat, Cereal, Recreation, Timber, OF_Meat, OF_Cereal


## Run

Right click the file './config/launcher/CraftyCoBRA_Demonstration.launch' and choose 'Run as...' > <First entry> Note: you need to substitute the project name first (see above)!


## ReleaseToLinuxCluster

This ant script facilitates the transfer of model configuration data to e.g. a linux cluster. The '-FS' version
of the script assumes you have mapped the cluster file system to a network drive of your local file system
(see [here](https://www.wiki.ed.ac.uk/display/ecdfwiki/Transferring+Data) for Eddie) 

## Some Notes

* CRAFTY-CoBRA supports parallel processing of regions which requires MPI to be present and mpi.jar in the Java
classpath. If MPI is not present, mpi.jar _must_ be excluded from the Java classpath. CRAFTY-CoBRA will then issue a warning (No MPI in classpath!) which can be ignored.

* CRAFTY-CoBRA currently issues a number of warnings from LEventbus. They basically mean that decision making
processes are triggered, but no actual decision for that trigger configured. In most cases the warnings can be 
ignored.

## Post-Processing
The folder ./config/R contains templates to aggregate and visualise simulation output data with R.
See [crafty wiki](https://www.wiki.ed.ac.uk/display/CRAFTY/Post-Processing) for details.

***

If you have any further questions don't hesitate to contact
Sascha.Holzhauer@ed.ac.uk 