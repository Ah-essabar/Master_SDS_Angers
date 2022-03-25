def resampleSensors(dictSensors,period='5T'):
    dict=dictSensors.copy()
    for cle, valeur in dict.items():       
        sensortemp = valeur.resample(period).mean()
        dictTemp= {cle: sensortemp }
        dict.update(dictTemp) 
    return dict


