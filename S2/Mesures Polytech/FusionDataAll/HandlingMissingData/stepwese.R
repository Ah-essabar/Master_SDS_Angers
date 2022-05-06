setwd("~/SDSStage/SDS-Stage/S2/Mesures Polytech/FusionDataAll/HandlingMissingData")
library(tidyverse)
library(caret)
library(leaps
        
library(MASS)
data1 = read.csv("data.csv")
data1$date <- NULL

# Fit the full model 
full.model <- lm(elec_general_219_w ~., data = data1)
# Stepwise regression model
step.model <- stepAIC(full.model, direction = "both", 
                      trace = FALSE)
summary(step.model)   
# Model accuracy
step.model$results
# Final model coefficients
step.model$finalModel
# Summary of the model
summary(step.model$finalModel)

