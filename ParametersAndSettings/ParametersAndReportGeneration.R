#####################################################
####################LOADING DATA#####################
#####################################################

cat("\n\nLoading Data ...\n\n")
DataSpecies <- read.csv(prstbl)                                  #READING TABLE OF PRESENCE/ABSENCE DATA
myResp <- as.numeric(DataSpecies[,myRespName])                   #READING PRESENCE AND ABSENCE COUNTS
myRespXY <- DataSpecies[,c(xname,yname)]                         #READING SPECIES XY COORDINATES

myBiomodData <- BIOMOD_FormatingData(resp.var = myResp,          #SETTING UP INPUTS FOR MODELING PIPELINE
                                     expl.var = myExpl, 
                                     resp.xy = myRespXY, 
                                     resp.name = myRespName)

#IF PSEUDOABSENCES ARE NEEDED, COPY FOLLOWING THREE LINES INTO THE 'BIOMOD_FormattingData' STATEMENT ABOVE AND CHANGE PARAMETERS FOR EACH
#                                    PA.nb.rep = XXXXXXXX,            #NUMBER OF REQUIRED PSEUDOABSENCE SELECTION (IF NEEDED). DEFAULT = 1
#                                    PA.nb.absences = XXXXXXXX,       #NUMBER OF PSEUDOABSENCES SELECTED FOR EACH REPETITION (WHEN PA.nb.rep > 0) OF SELECTION
#                                    PA.strategy = 'XXXXXXXX')        #STRATEGY FOR SELECTING THE PSEUDOABSENCES (MUST BE: 'random', 'sre', 'disk', or 'user.defined')

myBiomodData
plot(myBiomodData)                                #OPTIONALLY PLOT PRESENCE/ABSENCE POINTS IN R FOR OBSERVATION
myBiomodOption <- BIOMOD_ModelingOptions(          #OPTIONALLY ALTER INDIVIDUAL MODEL PARAMETERS
  #GLM = list(XXXXXXXX),
  #GBM = list(XXXXXXXX),
  #GAM = list(XXXXXXXX),
  #CTA = list(XXXXXXXX),
  #ANN = list(XXXXXXXX),
  #SRE = list(XXXXXXXX),
  #FDA = list(XXXXXXXX),
  #MARS = list(XXXXXXXX),
  #RF = list(XXXXXXXX),
  #MAXENT.Phillips =  list(XXXXXXXX),
  #MAXENT.Tsuruoka =  list(XXXXXXXX)
)
print("Done Loading Data")

#####################################################
###################RUNNING MODELS####################
#####################################################

cat("\n\nRunning Models ...\n\n")
myBiomodModelOut <- BIOMOD_Modeling(
  myBiomodData,
  models = c('GLM','GAM','GBM','SRE','CTA','ANN','FDA','MARS','RF','MAXENT.Phillips','MAXENT.Tsuruoka'),       #CHOOSE WHICH MODELS TO RUN, ALL 10 SELECTED AS DEFAULT
  models.options = myBiomodOption,
  NbRunEval=6,                                                  #CHOOSE NUMBER OF EVALUATION RUNS
  DataSplit=80,                                                 #CHOOSE DATASPLIT FOR TRAINING/TESTING
  Prevalence=NULL,                                              #NULL (default) or a 0-1 numeric used to build ’weighted response weights’
  VarImport=3,                                                  #NUMBER OF PERMUTATIONS TO ESTIMATE VARIABLE IMPORTANCE                                                  
  models.eval.meth = c('TSS','ROC','KAPPA'),                    #VECTOR NAMES OF EVALUATION METRICS AMONG 'KAPPA', 'TSS, 'ROC', 'FAR', 'SR', 'ACCURACY', 'BIAS', 'POD', 'CSI', and 'ETS'
  SaveObj = TRUE,                                               #KEEP ALL RESULTS AND OUTPUTS ON HARD DRIVE OR NOT (NOTE: STRONGLY RECOMMENDED)
  rescal.all.models = TRUE,                                     #IF TRUE, ALL MODEL PREDICTIONS WILL BE SCALED WITH A BINOMIAL GLM
  do.full.models = FALSE,                                       #IF TRUE, MODELS CALIBRATED AND EVALUATED WITH THE WHOLE DATASET ARE DONE
  modeling.id = paste(myRespName,"FirstModeling",sep=""))       #MODELING ID NAME
myBiomodModelEval <- get_evaluations(myBiomodModelOut)          #GETTING MODEL EVALUATIONS FOR PERFORMANCE TESTING
print("Done Running Models")

#####################################################
##################CREATING ENSEMBLE##################
#####################################################

cat("\n\nSetting Ensemble Parameters ...\n\n")
#SETTING PARAMETERS FOR ENSEMBLE MODELING
myBiomodEM <- BIOMOD_EnsembleModeling(
  modeling.output = myBiomodModelOut,
  chosen.models = 'all',                       #CHARACTER VECTOR OF WHICH MODELS TO INCLUDE IN ENSEMBLE
  em.by='all',                                 #DEFINING HOW MODELS WILL BE COMBINED:'PA_dataset+repet' (default), 'PA_dataset+algo', 'PA_dataset', 'algo' and 'all'
  eval.metric = c('TSS'),                      #VECTOR NAMES OF EVALUATION METRIC USED TO BUILD ENSEMBLE MODELS
  eval.metric.quality.threshold = c(0.2),      #If NOT 'NULL', THE MINIMUM SCORES BELOW WHICH MODELS WILL BE EXCLUDED FROM ENSEMBLE MODEL BUILDING
  models.eval.meth = c('TSS','ROC'),           #EVALUATION METHODS USED TO EVALUATE ENSEMBLE MODELS
  prob.mean = F,                               #LOGICAL. ESTIMATE THE MEAN PROBABLILITIES ACROSS PREDICTIONS
  prob.cv = F,                                 #LOGICAL. ESTIMATE THE COEFFICIENT OF VARIATION ACROSS PREDICTIONS
  prob.ci = F,                                 #LOGICAL. ESTIMATE THE CONFIDENCE INTERVAL AROUND THE PROB.MEAN
  prob.ci.alpha = 0.05,                        #NUMERIC. SIGNIFICANCE LEVEL FOR ESTIMATING THE CONFIDENCE INTERVAL. DEFAULT = 0.05
  prob.median = F,                             #LOGICAL. ESTIMATE THE MEDIANCE OF PROBABILITIES
  committee.averaging = F,                     #LOGICAL. ESTIMATE THE COMMITTEE AVERAGING ACROSS PREDICTIONS
  prob.mean.weight = T,                        #LOGICAL. ESTIMATE THE WEIGHTED SUM OF PROBABILITIES
  prob.mean.weight.decay = 'proportional' )    #DEFINE THE RELATIVE IMPORTANCE OF THE WEIGHTS. A HIGH VALUE WILL STRONGLY DISCRIMINATE THE 'GOOD' MODELS FROM THE 'BAD' 
print("Done Setting Ensemble Parameters")                 #ONES. IF 'PROPORTIONAL'’' (default), WEIGHTS ARE PROPORTIONAL TO EVALUATION SCORES

cat("\n\nProjecting Models ...\n\n")
#PROJECTING INDIVIDUAL MODELS ACROSS STUDY REGION
myBiomodProj <- BIOMOD_Projection(
  modeling.output = myBiomodModelOut,
  new.env = myExplProj,
  proj.name = projname,
  selected.models = 'all',                #'ALL' WHEN ALL MODELS HAVE TO BE USED TO RENDER PROJECTIONS OR A SUBSET VECTOR OF MODELLING.OUTPUT MODELS COMPUTED
  binary.meth = 'TSS',                    #A VECTOR OF A SUBSET OF MODELS EVALUATION METHOD COMPUTED BEFORE
  compress = 'xz',                        #BOOLEAN OR CHARACTER. THE COMPRESSION FORMAT OF OBJECTS STORED ON HARD DRIVE. TRUE, FALSE, XZ, OR GZIP
  clamping.mask = F,                      #LOGICAL. BUILD CLAMPING MASK OR NOT. SET TO FALSE TO PREVENT ERRORS
  output.format = '.grd')                 #OUTPUT FORMAT

outputFolderName <- paste("proj",projname,sep="_")
outputFolder <- paste(myRespName,outputFolderName,sep="/")      #FINDING DIRECTORY FOR ENSEMBLE MODEL OUTPUT FOR REPORT GENERATION
print("Done Projecting Models")

cat("\n\nCreating Ensemble ...\n\n")
#ENSEMBLE FORECASTING BASED ON PREVIOUSLY DEFINED WEIGHTING METHODS
myBiomodEF <- BIOMOD_EnsembleForecasting(
  EM.output = myBiomodEM,
  projection.output = myBiomodProj)       #YOU CAN ADD IN ARGUMENTS TO PROJECT MODELS UNDER DIFFERENT VARIABLES WITH 'NEW.ENV'
print("Done Creating Ensemble")

cat("\n\nExporting Ensemble as ASCII ...\n\n")
#EXPORTING ENSEMBLE MODEL PROJECTION AS ASCII FOR USE IN OUTSIDE MAPPING SOFTWARE
gridName = paste(outputFolderName,myRespName,"ensemble.grd",sep="_")  
gridDir = paste(myRespName,outputFolderName,gridName,sep="/")
MyRaster = raster(paste(myRespName,outputFolderName,gridName,sep="/"))
writeRaster(MyRaster,file="MyEnsembleRaster.asc", format = 'ascii', overwrite = TRUE)
print("Done Exporting Ensemble as ASCII")

#####################################################
###############VARIABLE DECISION TREES###############
#####################################################

cat("\n\nBuilding Decision Tree ...\n\n")
p.table <- read.csv(prstbl)                             #TABLE OF PRESENCE/ABSENCE DATA
xcol <- match(xname, names(p.table))                    #FINDING COLUMN NUMBER IN p.table FOR LOGITUDE
ycol <- match(yname, names(p.table))                    #FINDING COLUMN NUMBER IN p.table FOR LATITUDE
pacol <- match(myRespName, names(p.table))              #FINDING COLUMN NUMBER IN p.table FOR SPECIES
xy <- cbind(p.table[xcol], p.table[ycol])               #MAKING NEW OBJECT FOR LONG/LAT ONLY
sp <- SpatialPoints(xy)                                 #CONVERTING TO SPATIALPOINTS OBJECT
xy.extract <- extract(myExpl, sp)                       #EXTRACTING RASTER DATA TO POINTS IN SPATIALPOINTS OBJECT
xy.extract <- cbind(xy.extract, p.table[pacol])         #ADDING PRESENCE/ABSENCE COLUMN TO EXTRACTED RASTER VALUE OBJECT
write.csv(xy.extract, file = "xy_value_extract.csv")    #SAVING EXTRACTED VALUES TO CSV IN WD
xy.extract <- read.csv("xy_value_extract.csv")[,-1]     #IMPORTING CSV BACK IN, FIXING TYPE/CLASS ISSUES
idx_sp <- ncol(xy.extract)                              #FINDING LAST COLUMN WHERE SPECIES PRESENCE/ABSENCE DATA IS LOCATED
dat <- data.frame(xy.extract[,-idx_sp],
                  Species = as.factor(ifelse(xy.extract[,idx_sp] == 0, "absent","present")))        #MAKING NEW SPECIES COLUMN WITH PRESENCE/ABSENCE DATA
xy.tree <- rpart(Species ~ .,dat)                                                                   #BUILDING DECISION TREE FOR PRESENCE/ABSENCE AGAINST ALL EXTRACTED VARIABLE VALUES
dir.create("plots")
png("plots/decision_tree.png")
rpart.plot(xy.tree)            #SAVING PLOT OF DECISION TREE FOR REPORT GENERATION
dev.off()
print("Done Building Decision Tree")

#####################################################
##################GENERATING REPORT##################
#####################################################

cat("\n\nExporting Model Plots ...\n\n")
#EXPORTING PLOTS FOR EACH MODEL & ENSEMBLE TO 'PLOTS' FOLDER IN WD
dir.create("plots")
model_names <- c("GLM","GBM","GAM","ANN","SRE","CTA","RF","MARS","FDA","MAXENT.Phillips",'MAXENT.Tsuruoka')

#FUNCTION FOR PLOTTING PROJECTIONS FOR EACH MODEL AND PLACEHOLDERS FOR FAILED MODELS
plot_raster <- function(x,model){
  tryCatch({
    file_name <- paste("plots/", model,".png",sep="")
    png(file_name)
    raster::plot(x, str.grep = model)
    dev.off()
  }, error = function(e){
    file.copy("ParametersAndSettings/no_plot.png",file_name)
    cat("\n\nPlotting for ", model, " failed! Blank file created.\n\n",sep="")
  }
  )
}

for (i in 1:length(model_names)){
  plot_raster(myBiomodProj,model_names[i])
}

png("plots/ensemble.png")
raster::plot(myBiomodEF)
dev.off()
print("Done Exporting Model Plots")

#SAVING S4 STRUCTURES FOR REPORT GENERATION
saveRDS(myBiomodModelOut,"myBiomodModelOut.rds")
saveRDS(myBiomodModelEval,"myBiomodModelEval.rds")
variableimportance <- get_variables_importance(myBiomodModelOut)
saveRDS(variableimportance,"variableimportance.rds")
ensembleevaluation <- get_evaluations(myBiomodEM)
saveRDS(ensembleevaluation,"ensembleevaluation.rds")

cat("\n\nLGenerating Report ...\n\n")

#KNITTING RMARKDOWN PDF FROM 'Biomod2_Report.rmd' IN WD
library(rmarkdown)
rmarkdown::render('Biomod2_Report.rmd',output_format=html_document())                           #KNIT HTML REPORT
#Sys.setenv(PATH = paste(Sys.getenv("PATH"),
#    "C:/Program Files/MiKTeX 2.9/miktex/bin/x64", 
#    sep=.Platform$path.sep))                                #ADDING MikTeX to PATH, WILL BE DIFFERENT FOR OTHER LaTeX INSTALLATIONS
#rmarkdown::render('Biomod2_Report.rmd',
#     output_format=pdf_document(latex_engine='xelatex'))    #KNIT PDF REPORT, WILL REQUIRE LaTeX INSTALLATION AND SETUP.
print("Done Generating Report")