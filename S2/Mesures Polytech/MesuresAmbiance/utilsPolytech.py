import os
os.environ['NUMEXPR_MAX_THREADS'] = '16'

def outliers(data, drop=True)
    outlier_temp = np.where((raw_data['temperature'] >= (60)) ) # 60°C
    outlier_humidity = np.where(raw_data['humidity'] >= (100)) # 100 %
    outlier_tvoc = np.where(raw_data['tvoc'] >= (10000)) # 10 000 ppb
    outlier_light = np.where(raw_data['light'] >= (100000)) # 10 000
    outlier_sound = np.where(raw_data['sound'] >= (5000)) # 1 000
    outlier_co2 = np.where(raw_data['co2'] >= (65535)) # 

    outliers = np.unique(np.concatenate((outlier_temp[0],outlier_humidity[0],outlier_tvoc[0],
                                        outlier_light[0],outlier_sound[0],outlier_co2[0]),0))
    raw_data = raw_data.drop(outliers, inplace = True)
    

def resampleSensors(dictSensors,period='5T'):
    dict=dictSensors.copy()
    for cle, valeur in dict.items():       
        sensortemp = valeur.resample(period).mean()
        dictTemp= {cle: sensortemp }
        dict.update(dictTemp) 
    return dict


