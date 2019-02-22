import Magboltz
from GERJAN import GERJAN
import math

from RAND48 import Rand48
import numpy as np
from SORTT import SORTT

def ELIMITCT(Magboltz):
    
    ISAMP = 20
    SMALL = 1.0e-20
    I = 0
    API = Magboltz.API
    RTHETA = Magboltz.BTHETA*API/180.0
    EFZ100 = Magboltz.EFIELD*100*math.sin(RTHETA)
    EFX100 = Magboltz.EFIELD*100*math.cos(RTHETA)
    F1 = Magboltz.EFIELD*Magboltz.CONST2*math.cos(RTHETA)
    F4 =2*API
    EOVBR =Magboltz.EOVB *math.sin(RTHETA)
    RDUM = Magboltz.RSTART
    E1 = Magboltz.ESTART
    TDASH =0.0
    CONST9 = Magboltz.CONST3*0.01
    CONST10 = CONST9**2
    Magboltz.RNMX = GERJAN(RDUM,Magboltz.API)
    IMBPT = 0

    DCZ1 = math.cos(Magboltz.THETA)
    DCX1 = math.sin(Magboltz.THETA) * math.cos(Magboltz.PHI)
    DCY1 = math.sin(Magboltz.THETA) * math.sin(Magboltz.PHI)

    VTOT = CONST9 * math.sqrt(E1)
    CX1 = DCX1 * VTOT
    CY1 = DCY1 * VTOT
    CZ1 = DCZ1 * VTOT

    J2M = Magboltz.NMAX / ISAMP

    R5 = 1
    TLIM = 0
    EOK = 0
    Magboltz.RAND48.seed(RDUM)
    for J1 in range(int(J2M)):
        IE = 0
        E1 = 0
        EI = 0
        S1 = 0
        S2 = 0
        R5 = 1.0
        TLIM = 0.0
        while R5 > TLIM:
            R1 = Magboltz.RAND48.drand()
            T = -1 * np.log(R1) / Magboltz.TCFMX + TDASH
            TDASH = T
            WBT = Magboltz.WB * T
            COSWT = math.cos(WBT)
            SINWT = math.sin(WBT)
            DZ = (CZ1 * SINWT + (Magboltz.EOVB - CY1) * (1 - COSWT)) / Magboltz.WB
            DX = CX1 *T+F1*T*T

            E = E1 + DZ * EFZ100+DX*EFX100

            CX2 = CX1+2*F1*T
            CY2 = (CY1 - EOVBR) * COSWT + CZ1 * SINWT + EOVBR
            CZ2 = CZ1 * COSWT - (CY1 - EOVBR) * SINWT
            KGAS = 0
            R2 = Magboltz.RAND48.drand()
            while (Magboltz.TCFMXG[KGAS] < R2):
                KGAS += 1
            IMBPT += 1
            if IMBPT > 5:
                Magboltz.RNMX = GERJAN(RDUM, Magboltz.API)
                IMBPT = 0

            VGX = Magboltz.VTMB[KGAS] * Magboltz.RNMX[IMBPT%6]
            IMBPT += 1
            VGY = Magboltz.VTMB[KGAS] * Magboltz.RNMX[IMBPT%6]
            IMBPT += 1
            VGZ = Magboltz.VTMB[KGAS] * Magboltz.RNMX[IMBPT%6]

            EOK = ((CX2 - VGX) ** 2 + (CY2 - VGY) ** 2 + (CZ2 - VGZ) ** 2) / CONST10
            IE = int(EOK / Magboltz.ESTEP) + 1
            IE = min(IE, 3999)

            R5 = Magboltz.RAND48.drand()
            TLIM = Magboltz.TCF[KGAS][IE] / Magboltz.TCFMAX[KGAS]

        if IE == 3999:
            Magboltz.IELOW = 1


        TDASH = 0.0
        CONST11 = 1.0 / (CONST9 * math.sqrt(EOK))
        DXCOM = (CX2 - VGX) * CONST11
        DYCOM = (CY2 - VGY) * CONST11
        DZCOM = (CZ2 - VGZ) * CONST11

        R2 = Magboltz.RAND48.drand()
        I = 0
        I = SORTT(KGAS, I, R2, IE, Magboltz)
        while Magboltz.CF[KGAS][IE][I] < R2:
            I = I + 1
        S1 = Magboltz.RGAS[KGAS][I]
        EI = Magboltz.EIN[KGAS][I]
        if Magboltz.IPN[KGAS][I] > 0:
            R9 = Magboltz.RAND48.drand()
            EXTRA = R9 * (EOK - EI)
            EI = EXTRA + EI
        IPT = Magboltz.IARRY[KGAS][I]
        if EOK < EI:
            EI = EOK - 0.0001
        S2 = (S1 * S1) / (S1 - 1)
        R3 = Magboltz.RAND48.drand()

        if Magboltz.INDEX[KGAS][I] == 1:
            R31 = Magboltz.RAND48.drand()
            F3 = 1- R3 *Magboltz.ANGCT[KGAS][IE][I]
            if R31 > Magboltz.PSCT[KGAS][IE][I]:
                F3 = -1 * F3
            elif Magboltz.INDEX[KGAS][I] == 2:
                EPSI = Magboltz.PSCT[KGAS][IE][I]
                F3 = 1 - (2 * R3 * (1 - EPSI)) / (1 + EPSI * (1 - 2 * R3))
            else:
                F3 = 1 - 2 * R3
        THETA0 = math.acos(F3)
        R4 = Magboltz.RAND48.drand()
        PHI0 = F4 * R4
        F8 = math.sin(PHI0)
        F9 = math.cos(PHI0)
        ARG1 = 1 - S1 * EI / EOK
        ARG1 = max(ARG1, SMALL)

        D = 1 - F3 * math.sqrt(ARG1)
        E1 = EOK * (1 - EI / (S1 * EOK) - 2 * D / S2)
        E1 = max(E1, SMALL)
        Q = math.sqrt((EOK / E1) * ARG1) / S1
        Q = min(Q, 1)
        Magboltz.THETA = math.asin(Q * math.sin(THETA0))

        F6 = math.cos(Magboltz.THETA)
        U = (S1 - 1) * (S1 - 1) / ARG1
        CSQD = F3 ** 2

        if F3 < 0 and CSQD > U:
            F6 = -1 * F6
        F5 = math.sin(Magboltz.THETA)
        DZCOM = min(DZCOM, 1)
        ARGZ = math.sqrt(DXCOM * DXCOM + DYCOM * DYCOM)
        if ARGZ == 0:
            DCZ1 = F6
            DCX1 = F9 * F5
            DCY1 = F8 * F5
        else:
            DCZ1 = DZCOM * F6 + ARGZ * F5 * F8
            DCY1 = DYCOM * F6 + (F5 / ARGZ) * (DXCOM * F9 - DYCOM * DZCOM * F8)
            DCX1 = DXCOM * F6 - (F5 / ARGZ) * (DYCOM * F9 + DXCOM * DZCOM * F8)
        # TRANSFORM VELOCITY VECTORS TO LAB FRAME
        VTOT = CONST9 * math.sqrt(E1)
        CX1 = DCX1 * VTOT + VGX
        CY1 = DCY1 * VTOT + VGY
        CZ1 = DCZ1 * VTOT + VGZ
        #  CALCULATE ENERGY AND DIRECTION COSINES IN LAB FRAME
        E1 = (CX1 * CX1 + CY1 * CY1 + CZ1 * CZ1) / CONST10
        CONST11 = 1.0 / (CONST9 * math.sqrt(E1))
        DCX1 = CX1 * CONST11
        DCY1 = CY1 * CONST11
        DCZ1 = CZ1 * CONST11

    Magboltz.IELOW = 0
