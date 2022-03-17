
library(forecast)   # Most popular forecasting pkg
library(sweep)      # Broom tidiers for forecast pkg
library(timetk)
# Working with time series in R
library(imputeTS)
setwd("~/SDSStage/SDS-Stage/S2/IBSA")


dftemp <- read.csv(file = 'MCAR40.csv')



df=dftemp
df$Temperature<- na_kalman(df$Temperature, model = "auto.arima", smooth = TRUE)
df$Humidity<- na_kalman(df$Humidity, model = "auto.arima", smooth = TRUE)
df$CO2<- na_kalman(df$CO2, model = "auto.arima", smooth =TRUE)
df$Noise<- na_kalman(df$Noise, model = "auto.arima", smooth = TRUE)
df$Pressure<- na_kalman(df$Pressure,model = "auto.arima",  smooth =TRUE)

write.csv(df,"kalmanArima_TRUE_MCAR5.csv", row.names = FALSE)

df=dftemp
df$Temperature<- na_kalman(df$Temperature, model = "StructTS",smooth = TRUE)
df$Humidity<- na_kalman(df$Humidity, model = "StructTS",smooth = TRUE)
df$CO2<- na_kalman(df$CO2,model = "StructTS", smooth = TRUE)
df$Noise<- na_kalman(df$Noise, model = "StructTS", smooth = TRUE)
df$Pressure<- na_kalman(df$Pressure, model = "StructTS",smooth = TRUE)

write.csv(df,"kalmanStructTS_TRUE_MCAR5.csv", row.names = FALSE)


ggplot_na_distribution(df$CO2)
imp <- na_kalman(df$CO2)
ggplot_na_imputations(df$CO2, imp)

ilibrary(forecast)
tsAirgap %>% na_interpolation() %>% 
  ets() %>% forecast(h=36) %>% 
  autoplot()
