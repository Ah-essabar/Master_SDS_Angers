setwd("~/SDSStage/SDS-Stage/S2/Mesures Polytech/FusionDataAll/HandlingMissingData")
library(tidyverse)
library(caret)
library(leaps)
        
library(MASS)
data1 = read.csv("data.csv")
data1$date <- NULL

# Fit the full model 
model <- lm(elec_general_219_w ~., data = data1)
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
library(olsrr)
#view final model
forward$coefficients
k <- ols_step_all_possible(forward)
plot(k)
ols_step_best_subset(all)

#############################################################################""
lm(formula = elec_general_219_w ~ co2_100 + tvoc_100 + temperature_100 + 
     humidity_100 + light_100 + co2_101 + temperature_101 + humidity_101 + 
     light_101 + sound_101 + co2_102 + tvoc_102 + temperature_102 + 
     humidity_102 + light_102 + sound_102 + tvoc_103 + temperature_103 + 
     humidity_103 + light_103 + sound_103 + co2_104 + temperature_104 + 
     humidity_104 + light_104 + sound_104 + co2_105 + tvoc_105 + 
     temperature_105 + humidity_105 + light_105 + co2_106 + tvoc_106 + 
     temperature_106 + humidity_106 + light_106 + tvoc_107 + humidity_107 + 
     light_107 + sound_107 + tvoc_108 + temperature_108 + humidity_108 + 
     light_108 + co2_110 + temperature_110 + humidity_110 + co2_111 + 
     tvoc_111 + temperature_111 + humidity_111 + light_111 + sound_111 + 
     co2_112 + tvoc_112 + temperature_112 + humidity_112 + weather_out + 
     weather_hum + weather_bar_ + weather_rad_ + windows, data = data1)
###############################################################################################"

setwd("~/SDSStage/SDS-Stage/S2/Mesures Polytech/FusionDataAll/HandlingMissingData")

library(olsrr)
-------------------
  #Forward regression using p-values
data1 = read.csv("data.csv")
data1$date <- NULL

# Fit the full model 
model <- lm(elec_general_219_w ~., data = data1)  
  

FWDfit.p<-ols_step_forward_p(model,penter=.05)

#This gives you the short summary of the models at each step
FWDfit.p
-------------------
  #Forward regression using aic
 

FWDfit.aic<-ols_step_forward_aic(model)

#This gives you the short summary of the models at each step
FWDfit.aic

#This plots out the relative contributions of the predictors
plot(FWDfit.aic)

#if you want the intermediate steps, add set 'details' argument = TRUE

FWDfit.aic<-ols_step_forward_aic(model,details=TRUE)

-------------------
  #Backward regression using p-values
  
BWDfit.p<-ols_step_backward_p(model,prem=.05)

BWDfit.p

-------------------
  #Backward regression using aic
  
  BWDfit.aic<-ols_step_backward_aic(model)

BWDfit.aic

plot(BWDfit.aic)

#if you want the intermediate steps, add set 'details' argument = TRUE

BWDfit.aic<-ols_step_backward_aic(model,details=TRUE)

-------------------
  #Stepwise regression using p-values
  

Bothfit.p<-ols_step_both_p(model,pent=.05,prem=.05)

Bothfit.p

-------------------
  #Stepwise regression using aic
 
Bothfit.aic<-ols_step_both_aic(model)
Bothfit.aic

plot(Bothfit.aic)
-------------------
  #All possible subsets regression 
  

modcompare<-ols_step_all_possible(model)

modcompare

as.data.frame(modcompare)

#to obtain plots of Mallow's C and other indices
plot(modcompare)

-------------------
  #Best subsets regression
  

modcompare<-ols_step_best_subset(model)

modcompare

plot(modcompare)
