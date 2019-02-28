from Magboltz cimport Magboltz
from libc.math cimport sin, cos, acos, asin, log, sqrt,pow
from libc.string cimport memset
from Magboltz cimport drand48
from SORTT cimport SORTT
from libc.stdlib cimport malloc, free
import cython


@cython.cdivision(True)
@cython.boundscheck(False)
@cython.wraparound(False)
cdef double random_uniform(double dummy):
    cdef double r = drand48(dummy)
    return r

@cython.cdivision(True)
@cython.boundscheck(False)
@cython.wraparound(False)
cdef void GERJAN(double RDUM, double API,double *RNMX):
    cdef double RAN1, RAN2, TWOPI
    cdef int J
    for J in range(0, 5, 2):
        RAN1 = random_uniform(RDUM)
        RAN2 = random_uniform(RDUM)
        TWOPI = 2.0 * API
        RNMX[J] = sqrt(-1*log(RAN1)) * cos(RAN2 * TWOPI)
        RNMX[J + 1] = sqrt(-1*log(RAN1)) * sin(RAN2 * TWOPI)


@cython.cdivision(True)
@cython.boundscheck(False)
@cython.wraparound(False)
cpdef MONTET(Magboltz Object):
    Object.WX = 0.0
    Object.WY = 0.0
    Object.DWX = 0.0
    Object.DWY = 0.0
    Object.X = 0.0
    Object.Y = 0.0
    Object.Z = 0.0
    Object.ST = 0.0
    cdef long long I, ID, XID, NCOL, IEXTRA, IMBPT, K, J, J2M, J1, J2, KGAS, IE, IT, KDUM, IPT, JDUM,NCOLDM
    cdef double ST1, RDUM,ST2, SUME2, SUMXX, SUMYY, SUMZZ, SUMVX, SUMVY, ZOLD, STOLD, ST1OLD, ST2OLD, SZZOLD, SXXOLD, SYYOLD, SVXOLD, SVYOLD, SME2OLD, TDASH
    cdef double ABSFAKEI, DCZ1, DCX1, DCY1, CX1, CY1, CZ1, BP, F1, F2, F4, DCX2, DCY2, DCZ2, CX2, CY2, CZ2, DZCOM, DYCOM, DXCOM, THETA0,
    cdef double  E1, CONST9, CONST10, AP, CONST6, R2, R1, VGX, VGY, VGZ, VEX, VEY, VEZ, EOK, R5, TEST1, TEST2, TEST3, CONST11
    cdef double T2, A, B, CONST7, R3, S1, EI, R9, EXTRA, RAN, R31, F3, EPSI, R4, PHI0, F8, F9, ARG1, D, Q, F6, U, CSQD, F5, VXLAB, VYLAB, VZLAB
    cdef double TWZST, TAVE, T2WZST, T2AVE, TXXST, TYYST, T2XXST, T2YYST, TZZST, T2ZZST, ANCATT, ANCION, E
    I = 0
    ST1 = 0.0
    ST2 = 0.0
    SUME2 = 0.0
    SUMXX = 0.0
    SUMYY = 0.0
    SUMZZ = 0.0

    SUMVX = 0.0
    SUMVY = 0.0
    ZOLD = 0.0
    STOLD = 0.0
    ST1OLD = 0.0
    ST2OLD = 0.0
    SZZOLD = 0.0
    SXXOLD = 0.0
    SYYOLD = 0.0
    SVXOLD = 0.0
    SVYOLD = 0.0
    SME2OLD = 0.0
    cdef double *STO, *XST, *YST, *ZST, *WZST, *AVEST, *DFZZST, *DFYYST, *DFXXST
    STO = <double *> malloc(2000000 * sizeof(double))
    memset(STO, 0, 2000000 * sizeof(double))
    XST = <double *> malloc(2000000 * sizeof(double))
    memset(XST, 0, 2000000 * sizeof(double))

    YST = <double *> malloc(2000000 * sizeof(double))
    memset(YST, 0, 2000000 * sizeof(double))

    ZST = <double *> malloc(2000000 * sizeof(double))
    memset(ZST, 0, 2000000 * sizeof(double))

    WZST = <double *> malloc(10 * sizeof(double))
    memset(WZST, 0, 10 * sizeof(double))

    AVEST = <double *> malloc(10 * sizeof(double))
    memset(AVEST, 0, 10 * sizeof(double))

    DFZZST = <double *> malloc(10 * sizeof(double))
    memset(DFZZST, 0, 10 * sizeof(double))

    DFYYST = <double *> malloc(10 * sizeof(double))
    memset(DFYYST, 0, 10 * sizeof(double))

    DFXXST = <double *> malloc(10 * sizeof(double))
    memset(DFXXST, 0, 10 * sizeof(double))

    Object.SMALL = 1.0e-20
    Object.TMAX1 = 0.0
    RDUM = Object.RSTART
    E1 = Object.ESTART
    CONST9 = Object.CONST3 * 0.01
    CONST10 = pow(CONST9 , 2)
    Object.ITMAX = 10
    ID = 0
    Object.XID = 0
    NCOL = 0
    Object.NNULL = 0
    IEXTRA = 0
    GERJAN(Object.RSTART, Object.API, Object.RNMX)
    IMBPT = 0
    TDASH = 0.0
    cdef int i = 0
    cdef double ** TEMP = <double **> malloc(6 * sizeof(double *))
    for i in range(6):
        TEMP[i] = <double *> malloc(4000 * sizeof(double))
    for K in range(6):
        for J in range(4000):
            TEMP[K][J] = Object.TCF[K][J] + Object.TCFN[K][J]
    ABSFAKEI = 0.0
    Object.IFAKE = 0

    DCZ1 = cos(Object.THETA)
    DCX1 = sin(Object.THETA) * cos(Object.PHI)
    DCY1 = sin(Object.THETA) * sin(Object.PHI)

    BP = pow(Object.EFIELD , 2) * Object.CONST1
    F1 = Object.EFIELD * Object.CONST2
    F2 = Object.EFIELD * Object.CONST3
    F4 = 2.0 * acos(-1)
    print("F4=" + str(F4))
    J2M = <long long>(Object.NMAX / Object.ITMAX)
    for J1 in range(int(Object.ITMAX)):
        for J2 in range(int(J2M)):
            while True:
                R1 = random_uniform(RDUM)
                T = -log(R1) / Object.TCFMX + TDASH
                TDASH = T

                AP = DCZ1 * F2 * sqrt(E1)
                E = E1 + (AP + BP * T) * T
                CONST6 = sqrt(E1 / E)
                # CALCULATE DIRECTION COSINES BEFORE COLLISION
                DCX2 = DCX1 * CONST6
                DCY2 = DCY1 * CONST6
                DCZ2 = DCZ1 * CONST6 + Object.EFIELD * T * Object.CONST5 / sqrt(E)
                # FIND IDENTITY OF GAS FOR COLLISION
                KGAS = 0
                R2 = random_uniform(RDUM)
                if Object.NGAS == 1:
                    KGAS = 0
                else:
                    while (Object.TCFMXG[KGAS] < R2):
                        KGAS = KGAS + 1
                IMBPT += 1
                if (IMBPT > 6):
                    GERJAN(Object.RSTART, Object.API, Object.RNMX)
                    IMBPT = 1
                VGX = Object.VTMB[KGAS] * Object.RNMX[(IMBPT - 1) % 6]
                IMBPT += 1
                VGY = Object.VTMB[KGAS] * Object.RNMX[(IMBPT - 1) % 6]
                IMBPT += 1
                VGZ = Object.VTMB[KGAS] * Object.RNMX[(IMBPT - 1) % 6]
                # CALCULATE ELECTRON VELOCITY VECTORS VEX VEY VEZ
                VEX = DCX2 * CONST9 * sqrt(E)
                VEY = DCY2 * CONST9 * sqrt(E)
                VEZ = DCZ2 * CONST9 * sqrt(E)
                # CALCULATE ENERGY WITH STATIONARY GAS TARGET, EOK

                EOK = (pow((VEX - VGX) ,2) + pow((VEY - VGY) , 2) + pow((VEZ - VGZ) , 2)) / CONST10
                IE = int(EOK / Object.ESTEP)
                IE = min(IE, 3999)
                # TEST FOR REAL OR NULL COLLISION

                R5 = random_uniform(RDUM)
                TEST1 = Object.TCF[KGAS][IE] / Object.TCFMAX[KGAS]

                if R5 > TEST1:
                    Object.NNULL += 1
                    TEST2 = TEMP[KGAS][IE] / Object.TCFMAX[KGAS]
                    if R5 < TEST2:
                        if Object.NPLAST[KGAS] == 0:
                            continue
                        R2 = random_uniform(RDUM)
                        I = 0
                        while Object.CFN[KGAS][IE][I] < R2:
                            I += 1

                        Object.ICOLNN[KGAS][I] += 1
                        continue
                    else:
                        TEST3 = (TEMP[KGAS][IE] + ABSFAKEI) / Object.TCFMAX[KGAS]
                        if R5 < TEST3:
                            # FAKE IONISATION INCREMENT COUNTER
                            Object.IFAKE += 1
                            continue
                        continue
                else:
                    break
            NCOL += 1
            CONST11 = 1.0 / (CONST9 * sqrt(EOK))
            DXCOM = (VEX - VGX) * CONST11
            DYCOM = (VEY - VGY) * CONST11
            DZCOM = (VEZ - VGZ) * CONST11
            # CALCULATE POSITIONS AT INSTANT BEFORE COLLISION, & UPDATE DIFFUSION AND ENERGY CALCULATIONS
            T2 = T * T
            if (T >= Object.TMAX1):
                Object.TMAX1 = T
            TDASH = 0.0
            A = AP * T
            B = BP * T2
            SUME2 = SUME2 + T * (E1 + A / 2.0 + B / 3.0)
            CONST7 = CONST9 * sqrt(E1)
            A = T * CONST7
            #TODO: LIST
            CX1 = DCX1 * CONST7
            CY1 = DCY1 * CONST7
            Object.X = Object.X + DCX1 * A
            Object.Y = Object.Y + DCY1 * A
            Object.Z = Object.Z + DCZ1 * A + T2 * F1
            Object.ST = Object.ST + T
            IT = int(T)
            IT = min(IT, 299)
            Object.TIME[IT] += 1
            Object.SPEC[IE] += 1
            Object.WZ = Object.Z / Object.ST
            SUMVX = SUMVX + CX1 * CX1 * T2
            SUMVY = SUMVY + CY1 * CY1 * T2
            if ID != 0:
                KDUM = 0
                for JDUM in range(int(Object.NCORST)):
                    ST2 += T
                    NCOLDM = NCOL + KDUM
                    if NCOLDM > Object.NCOLM:
                        NCOLDM = NCOLDM - Object.NCOLM
                    SDIF = Object.ST - STO[NCOLDM - 1]
                    SUMXX =SUMXX+ pow((Object.X - XST[NCOLDM - 1]) , 2) * T / SDIF
                    SUMYY = SUMYY+pow((Object.Y - YST[NCOLDM - 1]) , 2) * T / SDIF
                    KDUM += Object.NCORLN
                    if J1 >= 2:
                        ST1 += T
                        SUMZZ += pow((Object.Z - ZST[NCOLDM - 1] - Object.WZ * SDIF) , 2) * T / SDIF
            XST[NCOL - 1] = Object.X
            YST[NCOL - 1] = Object.Y
            ZST[NCOL - 1] = Object.Z
            STO[NCOL - 1] = Object.ST
            if NCOL >= Object.NCOLM:
                ID += 1
                Object.XID = float(ID)
                NCOL = 0

            R3 = random_uniform(RDUM)

            I = SORTT(KGAS, I, R3, IE, Object)
            while Object.CF[KGAS][IE][I] < R3:
                I += 1
            S1 = Object.RGAS[KGAS][I]
            EI = Object.EIN[KGAS][I]

            if Object.IPN[KGAS][I] > 0:
                R9 = random_uniform(RDUM)
                EXTRA = R9 * (EOK - EI)
                EI = EXTRA + EI
                IEXTRA += <long long>Object.NC0[KGAS][I]
            IPT = <long long>Object.IARRY[KGAS][I]
            Object.ICOLL[KGAS][<int>IPT - 1] += 1
            Object.ICOLN[KGAS][I] += 1
            if EOK < EI:
                EI = EOK - 0.0001

            if Object.IPEN != 0:
                if Object.PENFRA[KGAS][0][I] != 0:
                    RAN = random_uniform(RDUM)
                    if RAN <= Object.PENFRA[KGAS][0][I]:
                        IEXTRA += 1
            S2 = pow(S1 , 2) / (S1 - 1.0)

            R3 = random_uniform(RDUM)
            if Object.INDEX[KGAS][I] == 1:
                R31 = random_uniform(RDUM)
                F3 = 1.0 - R3 * Object.ANGCT[KGAS][IE][I]
                if R31 > Object.PSCT[KGAS][IE][I]:
                    F3 = -1.0 * F3
            elif Object.INDEX[KGAS][I] == 2:
                EPSI = Object.PSCT[KGAS][IE][I]
                F3 = 1.0 - (2.0 * R3 * (1.0 - EPSI) / (1.0 + EPSI * (1.0 - 2.0 * R3)))
            else:
                F3 = 1.0 - 2.0 * R3
            THETA0 = acos(F3)
            R4 = random_uniform(RDUM)
            PHI0 = F4 * R4
            F8 = sin(PHI0)
            F9 = cos(PHI0)
            ARG1 = 1.0 - S1 * EI / EOK
            ARG1 = max(ARG1, Object.SMALL)
            D = 1.0 - F3 * sqrt(ARG1)
            E1 = EOK * (1.0 - EI / (S1 * EOK) - 2.0 * D / S2)
            E1 = max(E1, Object.SMALL)
            Q = sqrt((EOK / E1) * ARG1) / S1
            Q = min(Q, 1)
            Object.THETA = asin(Q * sin(THETA0))
            F6 = cos(Object.THETA)
            U = (S1 - 1) * (S1 - 1) / ARG1
            CSQD = F3 * F3
            if F3 < 0 and CSQD > U:
                F6 = -1 * F6
            F5 = sin(Object.THETA)
            DZCOM = min(DZCOM, 1.0)
            ARGZ = sqrt(DXCOM * DXCOM + DYCOM * DYCOM)
            if ARGZ == 0:
                DCZ1 = F6
                DCX1 = F9 * F5
                DCY1 = F8 * F5
            else:
                DCZ1 = DZCOM * F6 + ARGZ * F5 * F8
                DCY1 = DYCOM * F6 + (F5 / ARGZ) * (DXCOM * F9 - DYCOM * DZCOM * F8)
                DCX1 = DXCOM * F6 - (F5 / ARGZ) * (DYCOM * F9 + DXCOM * DZCOM * F8)
            CONST12 = CONST9 * sqrt(E1)
            VXLAB = DCX1 * CONST12 + VGX
            VYLAB = DCY1 * CONST12 + VGY
            VZLAB = DCZ1 * CONST12 + VGZ

            E1 = (VXLAB * VXLAB + VYLAB * VYLAB + VZLAB * VZLAB) / CONST10
            CONST11 = 1 / (CONST9 * sqrt(E1))
            DCX1 = VXLAB * CONST11
            DCY1 = VYLAB * CONST11
            DCZ1 = VZLAB * CONST11
        # TODO: TABLE PRINT
        Object.WZ *= 1.0e9
        Object.AVE = SUME2 / Object.ST
        Object.DIFLN = 0.0
        if Object.NISO == 0:
            Object.DIFXX = 5.0e15 * SUMVX / Object.ST
            Object.DIFYY = 5.0e15 * SUMVY / Object.ST
            DFXXST[J1] = 5.0e15 * (SUMVX - SVXOLD) / (Object.ST - STOLD)
            DFYYST[J1] = 5.0e15 * (SUMVY - SVYOLD) / (Object.ST - STOLD)
        else:
            if ST2 != 0.0:
                Object.DIFYY = 5.0e15 * SUMYY / ST2
                Object.DIFXX = 5.0e15 * SUMXX / ST2
                DFXXST[J1] = 5.0e15 * (SUMXX - SXXOLD) / (ST2 - ST2OLD)
                DFYYST[J1] = 5.0e15 * (SUMYY - SYYOLD) / (ST2 - ST2OLD)
            else:
                DFXXST[J1] = 0.0
                DFYYST[J1] = 0.0

        if ST1 != 0.0:
            Object.DIFZZ = 5.0e15 * SUMZZ / ST1
            DFZZST[J1] = 5.0e15 * (SUMZZ - SZZOLD) / (ST1 - ST1OLD)
        else:
            DFZZST[J1] = 0.0
        WZST[J1] = (Object.Z - ZOLD) / (Object.ST - STOLD) * 1.0e9
        AVEST[J1] = (SUME2 - SME2OLD) / (Object.ST - STOLD)
        ZOLD = Object.Z
        STOLD = Object.ST
        ST1OLD = ST1
        ST2OLD = ST2
        SVXOLD = SUMVX
        SVYOLD = SUMVY
        SZZOLD = SUMZZ
        SYYOLD = SUMYY
        SXXOLD = SUMXX
        SME2OLD = SUME2
        # TODO: CONTINUE TABLE PRINTING
        print(J1)
        if Object.SPEC[3999] > (1000 * float(J1)):
            raise ValueError("WARNING ENERGY OUT OF RANGE, INCREASE ELECTRON ENERGY INTEGRATION RANGE")

    TWZST = 0.0
    TAVE = 0.0
    T2WZST = 0.0
    T2AVE = 0.0
    TZZST = 0.0
    TYYST = 0.0
    TXXST = 0.0
    T2ZZST = 0.0
    T2YYST = 0.0
    T2XXST = 0.0
    for K in range(10):
        TWZST = TWZST + WZST[K]
        TAVE = TAVE + AVEST[K]
        T2WZST = T2WZST + WZST[K] * WZST[K]
        T2AVE = T2AVE + AVEST[K] * AVEST[K]
        TXXST = TXXST + DFXXST[K]
        TYYST = TYYST + DFYYST[K]
        T2YYST = T2YYST + pow(DFYYST[K] , 2)
        T2XXST = T2XXST + pow(DFXXST[K] ,2)
        if K >= 2:
            TZZST = TZZST + DFZZST[K]
            T2ZZST += pow(DFZZST[K] , 2)
    Object.DWZ = 100 * sqrt((T2WZST - TWZST * TWZST / 10.0) / 9.0) / Object.WZ
    Object.DEN = 100 * sqrt((T2AVE - TAVE * TAVE / 10.0) / 9.0) / Object.AVE
    Object.DXXER = 100 * sqrt((T2XXST - TXXST * TXXST / 10.0) / 9.0) / Object.DIFXX
    Object.DYYER = 100 * sqrt((T2YYST - TYYST * TYYST / 10.0) / 9.0) / Object.DIFYY
    Object.DZZER = 100 * sqrt((T2ZZST - TZZST * TZZST / 8.0) / 7.0) / Object.DIFZZ
    Object.DWZ = Object.DWZ / sqrt(10)
    Object.DEN = Object.DEN / sqrt(10)
    Object.DXXER = Object.DXXER / sqrt(10)
    Object.DYYER = Object.DYYER / sqrt(10)
    Object.DZZER = Object.DZZER / sqrt(8)
    Object.DIFLN = Object.DIFZZ
    Object.DIFTR = (Object.DIFXX + Object.DIFYY) / 2
    # CONVERT CM/SEC
    Object.WZ *= 1e5
    Object.DFLER = Object.DZZER
    Object.DFTER = (Object.DXXER + Object.DYYER) / 2.0

    ANCATT = 0.0
    ANCION = 0.0
    for I in range(Object.NGAS):
        ANCATT += Object.ICOLL[I][2]
        ANCION += Object.ICOLL[I][1]
    ANCION += IEXTRA
    Object.ATTER = 0.0

    if ANCATT != 0:
        Object.ATTER = 100 * sqrt(ANCATT) / ANCATT
    Object.ATT = ANCATT / (Object.ST * Object.WZ) * 1e12
    Object.ALPER = 0.0
    if ANCION != 0:
        Object.ALPER = 100 * sqrt(ANCION) / ANCION
    Object.ALPHA = ANCION / (Object.ST * Object.WZ) * 1e12
    free(STO)
    free(XST)
    free(YST)
    free(ZST)
    free(WZST)
    free(AVEST)
    free(DFZZST)
    free(DFYYST)
    free(DFXXST)
    for i in range(6):
        free(TEMP[i])
    free(TEMP)
    return Object
