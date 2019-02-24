
    obj.EFIELD = float(input("Enter EFIELD:"))
    obj.A = float(input("Enter A:"))
    obj.B = float(input("Enter B:"))
    obj.C = float(input("Enter C:"))
    obj.Org = float(input("Enter Org:"))
    obj.BMAG = 0
    obj.BTHETA = 90
    try:
        obj.Start()
        print(str((obj.FRAC[0]))) #CF4per
        print(str(("\n")))
        print(str((obj.FRAC[1]))) #ARper
        print(str(("\n")))
        print(str((obj.TEMPC)))   #TEMP
        print(str(("\n")))
        print(str((obj.TORR)))    #press
        print(str(("\n")))
        print(str((obj.EFIELD)))  #EFIELD
        print(str(("\n")))
        print(str(((obj.WZ*1e-5))))      #ZDRIFT
        print(str(("\n")))
        print(str((obj.DWZ)))     #ZERR
        print(str(("\n")))
        print(str((obj.DIFTR)))   #TDIFF
        print(str(("\n")))
        print(str((obj.DFTER)))  #TERR
        print(str(("\n")))
        print(str((obj.DIFLN)))   #LDIFF
        print(str(("\n")))
        print(str((obj.DFLER)))  #LERR
        print(str(("\n")))
        print(str((obj.AVE)))     #MELE
        print(str(("\n")))
        print(str((obj.DEN)))     #MERR
        print(str(("\n")))
        print(str(obj.DTOVMB))
    except ValueError:
        print("didnt work at i =" +str(i))

