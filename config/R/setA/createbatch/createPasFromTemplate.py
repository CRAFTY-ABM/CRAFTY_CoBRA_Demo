'''
Created on 09/09/16

see script name
 
@author: Sascha Holzhauer
'''

import csv
import re
import glob, os
from nt import mkdir

version = "V03"
countrycode = "EE"
templateFile = "C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/setA/createbatch/Pas_Template_" + countrycode + ".xml"
dataFile = "C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/config/R/setA/createbatch/TPB_Params_" + countrycode + "_" + version + ".csv"

# also change outfilename!

outdir = "C:/Data/LURG/workspace/CRAFTY_CoBRA_Demo/data/pas/" + version + "/"

indicator = "#"
nameindicator = "#Name"
thresholdindicator = "#Threshold"

with open(dataFile, 'r') as csvfile:
    datareader = csv.DictReader(csvfile, delimiter=',', quotechar='|')
    for row in datareader:
        data = {'mean': row, 'sd': datareader.__next__()}
        outFilename = outdir + "Pas_" + row['Type'] + "_" + countrycode + "_Cluster" + row["Cluster"] + ".xml"

        if not os.path.exists(os.path.dirname(outFilename)):
            os.makedirs(os.path.dirname(outFilename))

        inputFile = open(templateFile, "r")
        targetFile = open(outFilename, 'w')
        

        line =  inputFile.readline()
        while line != "":
            if nameindicator in line:
                line = line.replace(nameindicator, row['Type'] + "_Cluster" + row["Cluster"])
            if thresholdindicator in line:
                line = line.replace(thresholdindicator, data['mean']['Threshold'])
            if indicator in line:
                #print(line)
                # find placeholder
                for placeholder in re.findall ( '#(.*?)"', line):
                    line = line.replace(indicator + placeholder, data[re.findall("_(.*)", placeholder)[0]][re.findall("(.*)_", placeholder)[0]])
                #print(">>" + line)
            targetFile.write(line)
            line =  inputFile.readline()

inputFile.close()    
targetFile.close()
print("...finished")
