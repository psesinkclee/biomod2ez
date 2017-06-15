#####################################################
###############INSTALLING PACKAGES###################
#####################################################    

#THIS SCRIPT CONTAINS LOOPS TO CHECK FOR NECESSARY PACKAGES AND INSTALL THEM IF THEY ARE MISSING.

install.packages('biomod2')
install.packages('rgdal')
install.packages('raster')
install.packages('base')
install.packages('rpart')
install.packages('rpart.plot')
install.packages('rattle')
install.packages('reader')
install.packages('ggplot2')
install.packages('rmarkdown')
install.packages('tidyr')
install.packages('pander')

library('biomod2')
library('rgdal')
library('raster')
library('base')
library('rpart')
library('rpart.plot')
library('rattle')
library('reader')
library('ggplot2')
library('rmarkdown')
library('tidyr')
library('pander')

# 
# if(require("biomod2")){
#   print("package:biomod2 loaded correctly")
# } else {
#   print("installing package:biomod2...")
#   install.packages("biomod2")
#   if(require("biomod2")){
#     print("package:biomod2 installed and loaded")
#   } else {
#     stop("could not install package:biomod2")
#   }
# }
# 
# library(biomod2)
# 
# if(require("rgdal")){
#   print("package:rgdal loaded correctly")
# } else {
#   print("installing package:rgdal...")
#   install.packages("rgdal")
#   if(require("rgdal")){
#     print("package:rgdal installed and loaded")
#   } else {
#     stop("could not install package:rgdal")
#   }
# }
# 
# library(rgdal)
# 
# if(require("raster")){
#   print("package:raster loaded correctly")
# } else {
#   print("installing package:raster...")
#   install.packages("raster")
#   if(require("raster")){
#     print("package:raster installed and loaded")
#   } else {
#     stop("could not install package:raster")
#   }
# }
# 
# library(rgdal)
# 
# if(require("base")){
#   print("package:base loaded correctly")
# } else {
#   print("installing package:base...")
#   install.packages("base")
#   if(require("base")){
#     print("package:base installed and loaded")
#   } else {
#     stop("could not install package:base")
#   }
# }
# 
# library(base)
# 
# if(require("rpart")){
#   print("package:rpart loaded correctly")
# } else {
#   print("installing package:rpart...")
#   install.packages("rpart")
#   if(require("rpart")){
#     print("package:rpart installed and loaded")
#   } else {
#     stop("could not install package:rpart")
#   }
# }
# 
# library(rpart)
# 
# if(require("rpart.plot")){
#   print("package:rpart.plot loaded correctly")
# } else {
#   print("installing package:rpart.plot...")
#   install.packages("rpart.plot")
#   if(require("rpart.plot")){
#     print("package:rpart.plot installed and loaded")
#   } else {
#     stop("could not install package:rpart.plot")
#   }
# }
# 
# library(rpart.plot)
# 
# if(require("rattle")){
#   print("package:rattle loaded correctly")
# } else {
#   print("installing package:rattle...")
#   install.packages("rattle")
#   if(require("rattle")){
#     print("package:rattle installed and loaded")
#   } else {
#     stop("could not install package:rattle")
#   }
# }
# 
# library(rattle)
# 
# if(require("readr")){
#   print("package:readr loaded correctly")
# } else {
#   print("installing package:readr...")
#   install.packages("readr")
#   if(require("readr")){
#     print("package:readr installed and loaded")
#   } else {
#     stop("could not install package:readr")
#   }
# }
# 
# library(readr)
# 
# if(require("rmarkdown")){
#   print("package:rmarkdown loaded correctly")
# } else {
#   print("installing package:rmarkdown...")
#   install.packages("rmarkdown")
#   if(require("rmarkdown")){
#     print("package:rmarkdown installed and loaded")
#   } else {
#     stop("could not install package:rmarkdown")
#   }
# }
# 
# library(rmarkdown)
# 
# if(require("tidyr")){
#   print("package:tidyr loaded correctly")
# } else {
#   print("installing package:tidyr...")
#   install.packages("tidyr")
#   if(require("tidyr")){
#     print("package:tidyr installed and loaded")
#   } else {
#     stop("could not install package:tidyr")
#   }
# }
# 
# library(tidyr)
# 
# if(require("pander")){
#   print("package:pander loaded correctly")
# } else {
#   print("installing package:pander...")
#   install.packages("pander")
#   if(require("pander")){
#     print("package:pander installed and loaded")
#   } else {
#     stop("could not install package:pander")
#   }
# }
# 
# library(pander)
# 
# if(require("ggplot2")){
#   print("package:ggplot2 loaded correctly")
# } else {
#   print("installing package:ggplot2...")
#   install.packages("ggplot2")
#   if(require("ggplot2")){
#     print("package:ggplot2 installed and loaded")
#   } else {
#     stop("could not install package:ggplot2")
#   }
# }
# 
# library(ggplot2)
# 
# if(require("rpart.plot")){
#   print("package:rpart.plot loaded correctly")
# } else {
#   print("installing package:rpart.plot...")
#   install.packages("rpart.plot")
#   if(require("rpart.plot")){
#     print("package:rpart.plot installed and loaded")
#   } else {
#     stop("could not install package:rpart.plot")
#   }
# }
# 
# library(rpart.plot)
# 
# 
# if(require("rmarkdown")){
#   print("package:rmarkdown loaded correctly")
# } else {
#   print("installing package:rmarkdown...")
#   install.packages("rmarkdown")
#   if(require("rmarkdown")){
#     print("package:rmarkdown installed and loaded")
#   } else {
#     stop("could not install package:rmarkdown")
#   }
# }
# 
# library(rmarkdown)