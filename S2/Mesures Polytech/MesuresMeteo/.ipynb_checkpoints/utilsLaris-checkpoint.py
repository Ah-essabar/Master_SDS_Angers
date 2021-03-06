def separteSensors(data, filename, save=False):
    import pandas as pd
    import numpy as np
    # Number of sensors
    nb_sensors = len(pd.unique(data['sensor'])) 
    sensors_list = data.sensor.unique()
    print("We have ",nb_sensors," sensors. Their Id are ", [i_sensor for i,i_sensor in enumerate(sensors_list)])

    # Separate each sensor data and create a dictionary for all sensors 
    # the dataframe of each senor can be extracted from dictionary ex : DataSensors["sensor_100"]
    DataSensors={}
    for i,i_sensor in enumerate(sensors_list):
        globals()['sensor_%s' % i_sensor] = data.loc[data["sensor"]==i_sensor]    
        globals()['sensor_%s' % i_sensor] = globals()['sensor_%s' % i_sensor].set_index('date')
        globals()['sensor_%s' % i_sensor].drop(["id","sensor","room"],axis=1, inplace = True)
        globals()['sensor_%s' % i_sensor].columns = globals()['sensor_%s' % i_sensor].columns+'_'+str(i_sensor)    
        globals()['sensor_%s' % i_sensor].index = pd.to_datetime(globals()['sensor_%s' % i_sensor].index,dayfirst=True)
        globals()['sensor_%s' % i_sensor].sort_index(inplace=True) # index sorted
        print('sensor_{}'.format(i_sensor))
        dictTemp= {'sensor_%s' % i_sensor: globals()['sensor_%s' % i_sensor] }
        DataSensors.update(dictTemp)
    # Save all sensors in dictionary
    if save:
        np.save(filename+'.npy', DataSensors)
    return DataSensors  
    

## fusion des données par master and all
def dataFusion(dictSensors, salle=219):
    salle = int(salle)
    if salle == 219:
        dict=dictSensors.copy()
        dfs =[dict['sensor_100'],dict['sensor_101'],dict['sensor_102'], dict['sensor_103']]
        df1 = dfs[0].join(dfs[1:])
        dfs =[dict['sensor_104'],dict['sensor_105'],dict['sensor_106'], dict['sensor_107']]
        df2 = dfs[0].join(dfs[1:])
        dfs =[dict['sensor_108'],dict['sensor_109'],dict['sensor_110']]
        df3 = dfs[0].join(dfs[1:])
        dfs =[dict['sensor_111'],dict['sensor_112'],dict['sensor_113']]
        df4 = dfs[0].join(dfs[1:])
        dfs = [df1,df2,df3,df4]
        df = dfs[0].join(dfs[1:])
        return df1,df2,df3,df4,df
    if salle == 114:
        dict=dictSensors.copy()
        dfs =[dict['sensor_118'],dict['sensor_119'],dict['sensor_120']]
        df1 = dfs[0].join(dfs[1:])
        dfs =[dict['sensor_121'],dict['sensor_122'],dict['sensor_123']]
        df2 = dfs[0].join(dfs[1:])
        dfs =[dict['sensor_124'],dict['sensor_125'],dict['sensor_126']]
        df3 = dfs[0].join(dfs[1:])
        dfs =[dict['sensor_127'],dict['sensor_128'],dict['sensor_129']]
        df4 = dfs[0].join(dfs[1:])
        dfs = [df1,df2,df3,df4]
        df = dfs[0].join(dfs[1:])
        return df1,df2,df3,df4,df
    


def resampleSensors(dictSensors,period='5T'):
    dict=dictSensors.copy()
    for cle, valeur in dict.items():       
        sensortemp = valeur.resample(period).mean()
        dictTemp= {cle: sensortemp }
        dict.update(dictTemp) 
    return dict



def outliersToNan(data):     
    import numpy as np
    outlier_temp = np.where((data['temperature'] >= (60)) ) # 60°C
    outlier_humidity = np.where(data['humidity'] >= (100)) # 100 %
    outlier_tvoc = np.where(data['tvoc'] >= (10000)) # 10 000 ppb
    #outlier_light = np.where(data['light'] >= (100000)) # 10 000
    outlier_light = np.where(data['light'] >= (65535)) # 10 000
    outlier_sound = np.where(data['sound'] >= (5000)) # 1 000
    outlier_co2 = np.where(data['co2'] >= (10000)) # 65535
    outliers = np.unique(np.concatenate((outlier_temp[0],outlier_humidity[0],outlier_tvoc[0],
                                        outlier_light[0],outlier_sound[0],outlier_co2[0]),0))
    data.loc[outlier_temp[0],"temperature"] = np.nan
    data.loc[outlier_humidity[0],"humidity"] = np.nan
    data.loc[outlier_tvoc[0],"tvoc"] = np.nan
    data.loc[outlier_light[0],"light"] = np.nan
    data.loc[outlier_sound[0],"sound"] = np.nan
    data.loc[outlier_co2[0],"co2"] = np.nan
    return data, outliers



    
    
    