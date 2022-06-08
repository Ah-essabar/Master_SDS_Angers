
library(forecast)   # Most popular forecasting pkg
library(sweep)      # Broom tidiers for forecast pkg
library(timetk)
# Working with time series in R
library(imputeTS)
setwd("C:/Users/ahmed/Desktop/BDD_missingData")

fichiers = c("MCAR05.csv","MCAR10.csv","MCAR25.csv","MCAR40.csv","MCAR60.csv","MCAR70.csv", "MAR05.csv","MAR10.csv","MAR25.csv","MAR40.csv","MAR60.csv","MAR70.csv")
for (i in 1:12) {
  fichier = fichiers[i]
  print(i)
  filename = paste("Imputed/kalmanArima_",fichier,sep="")
  dftemp <- read.csv(file = fichier)
  names(dftemp) 
  df=dftemp
  df$co2_100<- na_kalman(df$co2_100, model = "auto.arima", smooth = TRUE)
  df$temperature_100<- na_kalman(df$temperature_100, model = "auto.arima", smooth = TRUE)
  df$co2_101<- na_kalman(df$co2_101, model = "auto.arima", smooth =TRUE)
  df$temperature_101<- na_kalman(df$temperature_101, model = "auto.arima", smooth = TRUE)
  df$co2_102<- na_kalman(df$co2_102,model = "auto.arima",  smooth =TRUE)
  df$temperature_105<- na_kalman(df$temperature_105, model = "auto.arima", smooth = TRUE)
  df$co2_106<- na_kalman(df$co2_106, model = "auto.arima", smooth = TRUE)
  df$light_106<- na_kalman(df$light_106, model = "auto.arima", smooth =TRUE)
  df$co2_107<- na_kalman(df$co2_107,model = "auto.arima",  smooth =TRUE)
  df$co2_108<- na_kalman(df$co2_108,model = "auto.arima",  smooth =TRUE)
  df$sound_108<- na_kalman(df$sound_108,model = "auto.arima",  smooth =TRUE)
  df$humidity_110<- na_kalman(df$humidity_110,model = "auto.arima",  smooth =TRUE)
  df$weather_out<- na_kalman(df$weather_out,model = "auto.arima",  smooth =TRUE)
  df$weather_hum<- na_kalman(df$weather_hum,model = "auto.arima",  smooth =TRUE)
  df$weather_bar_<- na_kalman(df$weather_bar_,model = "auto.arima",  smooth =TRUE)
  df$windows<- na_kalman(df$windows,model = "auto.arima",  smooth =TRUE)
  write.csv(df,filename, row.names = FALSE)
  
}









ggplot_na_distribution(df$CO2)
imp <- na_kalman(df$CO2)
ggplot_na_imputations(df$CO2, imp)

ilibrary(forecast)
tsAirgap %>% na_interpolation() %>% 
  ets() %>% forecast(h=36) %>% 
  autoplot()
