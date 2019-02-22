import sys
import warnings
import time
warnings.filterwarnings("ignore", message="numpy.dtype size changed")
warnings.filterwarnings("ignore", message="numpy.ufunc size changed")
sys.path.append('../../src/Scripts/Python')

from Magboltz import Magboltz

obj = Magboltz()
E = [50,100,150,200,250,300,350,400]
for i in range(8):
    obj.__init__()
    obj.NGAS =1
    obj.NMAX = 10
    obj.IPEN = 0
    obj.ITHRM=1
    obj.EFINAL = 0.0
    obj.NGASN=[7,0,0,0,0,0]
    obj.FRAC=[100,0,0,0,0,0]
    obj.TEMPC = 23
    obj.TORR = 750.062
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
    except ValueError:
        print("didnt work at i =" +str(i))
f.close()

