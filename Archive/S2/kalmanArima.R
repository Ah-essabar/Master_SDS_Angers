
library(forecast)   # Most popular forecasting pkg
library(sweep)      # Broom tidiers for forecast pkg
library(timetk)
# Working with time series in R
library(imputeTS)

df40MCAR$Temperature<- na_kalman(df40MCAR$Temperature, smooth = TRUE)
df40MCAR$Humidity<- na_kalman(df40MCAR$Humidity, smooth = TRUE)
df40MCAR$CO2<- na_kalman(df40MCAR$CO2, smooth = TRUE)
df40MCAR$Noise<- na_kalman(df40MCAR$Noise, smooth = TRUE)
df40MCAR$Pressure<- na_kalman(df40MCAR$Pressure, smooth = TRUE)