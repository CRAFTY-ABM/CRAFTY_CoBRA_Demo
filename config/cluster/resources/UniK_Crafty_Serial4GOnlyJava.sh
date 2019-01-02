#!/bin/sh

# Job Name:
#SBATCH --job-name=CRAFTY_%SCENARIONAME%_%FIRST_RUN%-%RANDOM_SEED_OFFSET%

#SBATCH -p public


# Requested total running time (?) (HH:MM:SS):
#SBATCH --time=8:00:00

# Requested total memory:
#SBATCH --mem=19g

#SBATCH --nodes=1
#SBATCH --tasks-per-node=2

# Name of output files:
#SBATCH --output=./output/%SCENARIO%/%FIRST_RUN%-%RANDOM_SEED_OFFSET%/CRAFTY_%SCENARIONAME%_%FIRST_RUN%-%RANDOM_SEED_OFFSET%.out
#SBATCH --error=./output/%SCENARIO%/%FIRST_RUN%-%RANDOM_SEED_OFFSET%/CRAFTY_%SCENARIONAME%_%FIRST_RUN%-%RANDOM_SEED_OFFSET%.err

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
echo "####################################################"


echo "Der Job wird auf der folgenden Maschine bearbeitet:: $SLURM_JOB_NODELIST"
echo "##########################################################"

. /etc/profile.d/modules.sh
module load R/3.4.2

#export LD_PRELOAD=$JAVA_HOME/jre/lib/amd64/libjsig.so

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/exports/csce/eddie/geos/groups/LURG/mpiJava/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/users/sholzhau/R/R-3.0.0/library/rJava/jri

export JAVA_HOME=/opt/java/jdk1.8u65
export JAVA_LD_LIBRARY_PATH='/gpfs/home03/redhat5/hrz$(JAVA_HOME)/jre/lib/amd64/server'
export JAVA_CPPFLAGS='-I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/linux'

cd ${SLURM_SUBMIT_DIR}

mkdir -p ./output/%SCENARIO%/%FIRST_RUN%-%RANDOM_SEED_OFFSET%

# Start des Jobs:
java -classpath ./config/log/ -Xmx18g -Dlog4j.configuration=./config/log/log4j_cluster.properties -jar CRAFTY_CoBRA_Demo.jar -f "%SCENARIO_FILE%" -d "%DATA_FOLDER%" -s %START_TICK% -e %END_TICK% -n %NUM_RUNS% -sr %FIRST_RUN% -r %NUM_RANDOM_SEEDS% -o %RANDOM_SEED_OFFSET%

echo "##########################################################"
echo "Job finished: " `date`
exit 0
