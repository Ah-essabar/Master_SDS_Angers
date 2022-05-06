setwd("~/SDSStage/SDS-Stage/S2/Mesures Polytech/FusionDataAll/HandlingMissingData")
library(tidyverse)
library(caret)
library(leaps)
        
library(MASS)
data1 = read.csv("data.csv")
data1$date <- NULL

# Fit the full model 
full.model <- lm(elec_general_219_w ~., data = data1)
# Stepwise regression model
step.model <- stepAIC(full.model, direction = "both", trace = FALSE)
summary(step.model)   
# Model accuracy
step.model$results
# Final model coefficients
step.model$finalModel
# Summary of the model
summary(step.model$finalModel)
step.model$bestTune
################################################################

#define intercept-only model
intercept_only <- lm(elec_general_219_w ~ 1, data=data1)

#define model with all predictors
all <- lm(elec_general_219_w ~ ., data=data1)

#perform forward stepwise regression
forward <- step(intercept_only, direction='forward', scope=formula(all), trace=1)

#view results of forward stepwise regression
forward$anova
#view final model
forward$coefficients
k <- ols_step_all_possible(forward)
plot(k)
ols_step_best_subset(all)
