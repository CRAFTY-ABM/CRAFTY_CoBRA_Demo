#!/bin/sh

# Job Name:
#SBATCH --job-name=CRAFTY_%SCENARIONAME%_%FIRST_RUN%-%RANDOM_SEED_OFFSET%

#SBATCH -p public


# Requested total running time (?) (HH:MM:SS):
#SBATCH --time=2:00:00

# Requested total memory:
#SBATCH --mem=9g


#SBATCH --nodes=1
#SBATCH --tasks-per-node=1

# Name of output files:
#SBATCH --output=./output/%SCENARIO%/%FIRST_RUN%-%RANDOM_SEED_OFFSET%/CRAFTY_%SCENARIONAME%_%FIRST_RUN%-%RANDOM_SEED_OFFSET%_R.out
#SBATCH --error=./output/%SCENARIO%/%FIRST_RUN%-%RANDOM_SEED_OFFSET%/CRAFTY_%SCENARIONAME%_%FIRST_RUN%-%RANDOM_SEED_OFFSET%_R.err

# Send mail when job is aborted or terminates
#SBATCH --mail-type=ALL
#SBATCH --mail-user=Sascha.Holzhauer@uni-kassel.de


# Ausgabe der Umgebung des Jobs:
echo "####################################################"
echo "Nutzerkennung: $SBATCH_ACCOUNT"
echo "PBS job id: $SLURM_JOB_ID"
echo "PBS job name: $SLURM_JOB_NAME"
echo "PBS working directory: $SLURM_SUBMIT_DIR"
echo "Job gestartet auf " `hostname` at `date`
echo "Aktuelles Verzeichnis:" `pwd`
echo "PBS Umgebung: $PBS_ENVIRONMENT"
echo "Testtoken"
echo "####################################################"


echo "Der Job wird auf der folgenden Maschine bearbeitet:: $SLURM_JOB_NODELIST"
echo "##########################################################"

. /etc/profile.d/modules.sh
#module switch R/3.1.2 R/3.4.2
#module unload R/*
module purge

# module list
# echo "------"

export R_LIBS_USER="/home/users/0033/uk052959/R/x86_64-pc-linux-gnu-library/3.5/"

#export LD_PRELOAD=$JAVA_HOME/jre/lib/amd64/libjsig.so

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/exports/csce/eddie/geos/groups/LURG/mpiJava/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/users/sholzhau/R/R-3.0.0/library/rJava/jri

export JAVA_HOME=/opt/java/jdk1.8u65
export JAVA_LD_LIBRARY_PATH='/gpfs/home03/redhat5/hrz$(JAVA_HOME)/jre/lib/amd64/server'
export JAVA_CPPFLAGS='-I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/linux'

cd ${SLURM_SUBMIT_DIR}

echo "########## Start R Scripts...#######################"
Rscript ./config/R/%SCENARIO%/cluster/common/process.R "--firstrun=%FIRST_RUN%" "--numrun=%NUM_RUNS%" "--seedoffset=%RANDOM_SEED_OFFSET%" "--numrandomseeds=%NUM_RANDOM_SEEDS%"

echo "##########################################################"
echo "Job finished: " `date`
exit 0
