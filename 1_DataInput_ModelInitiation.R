##############################################################################
################################# DATA SETUP #################################
##############################################################################

# NOTE: PLEASE REFER TO THE README DOCUMENT BEFORE USING THIS SCRIPT TO ENSURE 
#       THAT YOU UNDERSTAND HOW THESE SCRIPTS WORK.
#
#       ERRORS MAY OCCUR WHILE RUNNING THESE MODELS AND YOU MAY NEED TO ALTER
#       PORTIONS OF SCRIPTS TO GET IT RUNNING PROPERLY ON YOUR MACHINE.
#
#       THIS IS A COMPLETE TEMPLATE FOR CREATING MODELS AND GENERATING
#       ENSEMBLE PROJECTIONS FOR YOUR STUDY TAXA.
#
#       THESE ARE LIKELY NOT THE BEST SETTINGS FOR ALL DATA, AND WILL NEED
#       TWEAKING TO WORK BEST WITH YOUR DATASET.


setwd("XXXXXXXX")                                      #INSERT THE FILEPATH TO YOUR WORKING DIRECTORY HERE.
source("ParametersAndSettings/InstallingPackages.R")   #RUNNING AUXILIARY SCRIPT TO CHECK FOR AND INSTALL NECESSARY PACKAGES.
#rasterOptions(tmpdir="XXXXXXXX")                      #OPTIONALLY SET TEMP FOLDER.
prstbl = "XXXXXXXX"                                    #INSERT THE FILEPATH TO YOUR PRESENCE/ABSENCE TABLE HERE.
myRespName = "XXXXXXXX"                                #NAME OF COLUMN WITH SPECIES DATA.
xname = "XXXXXXXX"                                     #NAME OF COLUMN WITH 'X' COORDINATE.
yname = "XXXXXXXX"                                     #NAME OF COLUMN WITH 'Y' COORDINATE.
myExpl = raster::stack(("XXXXXXXX"),                   #INSERT FILEPATHS TO EACH PREDICTOR VARIABLE HERE AND ADD MORE ENTRIES AS NEEDED.
                       ("XXXXXXXX"),                              
                       ("XXXXXXXX"))

myExplProj = myExpl
projname = "XXXXXXXX"                                  #REPLACE XXXXXXXX WITH A NAME FOR YOUR PROJECT

# NOTE: IF PROJECTING UNDER ALTERNATE CONDITIONS, UNCOMMENT THE FOLLOWING CODE BLOCK AND COMPLETE IT

#projname = "XXXXXXXX"                                 #REPLACE XXXXXXXX WITH A NAME FOR YOUR PROJECTION
#myExplProj = stack(("XXXXXXXX"),                      #INSERT FILEPATHS TO EACH PREDICTOR VARIABLE HERE AND ADD MORE ENTRIES AS NEEDED
#                   ("XXXXXXXX"),                      #THESE MUST MATCH THE NAMES OF THE VARIABLE USED IN THE ORIGINAL RASTER STACK ABOVE
#                   ("XXXXXXXX"),
#                   ("XXXXXXXX"),
#                   ("XXXXXXXX"))



##############################################################################
############################### RUNNING MODELS ###############################
##############################################################################

# NOTE: EDIT THE FILE SOURCED BELOW TO CHANGE SETTINGS FOR MODEL GENERATION.
#
#       THESE ARE NOT THE BEST SETTINGS FOR ALL DATASETS AND THERE IS ROOM 
#       FOR MODIFICATIONS TO STRENGTHEN YOUR MODEL.
#
#       WHEN YOUR SETTINGS ARE READY, RUN THE FOLLOWING COMMAND.
#
#       RUNNING THIS SCRIPT WILL SET UP YOUR DATA, RUN MODELS, CREATE 
#       INDIVIDUAL AND ENSEMBLE PROJECTIONS, AND GENERATE A PDF REPORT.
#
#       AN ASCII RASTER OF YOUR ENSEMBLE MODEL WILL BE SAVED TO THE WD.


source("ParametersAndSettings/ParametersAndReportGeneration.R")
