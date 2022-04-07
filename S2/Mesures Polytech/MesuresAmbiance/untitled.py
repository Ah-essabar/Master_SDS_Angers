def importData():
    import utilsLaris
    import os
    import wget
    
    if os.path.isfile("s114.php")==True:
        os. remove("s114.php")
    if os.path.isfile("s219.php")==True:
        os. remove("s219.php")
    if os.path.isfile("shelly.php")==True:
        os. remove("shelly.php")    
    wget.download("https://biot.u-angers.fr/s219.php")
    wget.download("https://biot.u-angers.fr/s114.php")
    wget.download("https://biot.u-angers.fr/shelly.php")

    for salle in ["s114",'s219']:
        #raw_data = pd.read_csv("test.txt", sep=";")
        sallePhp = salle
        raw_data = pd.read_csv(sallePhp+".php", sep=";")
        data,outliers = utilsLaris.outliersToNan(raw_data)
        # Separate sensors and save as dictionary
        filename = sallePhp
        # separteSensors(data, filename, save=False)
        DataSensors = utilsLaris.separteSensors(data,filename, True )