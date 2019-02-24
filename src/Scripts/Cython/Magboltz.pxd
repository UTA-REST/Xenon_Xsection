cimport numpy as np
import math
from libc.stdlib cimport malloc, free
from libc.string cimport memset

cdef double drand48(double dummy)

cdef class Magboltz:
    cdef public:
        double EOVB, WB, BTHETA, BMAG, EFINAL, ESTEP, AKT, ARY, TEMPC, TORR, TMAX, SMALL, API, ESTART, THETA, PHI, EFIELD, NMAX, ALPHA
        double WX, WY, WZ, DWX, DWY, DWZ, TTOTS, ATT, ALPER, ATTER, DIFLN, DIFTR, DIFXX, DIFYY, DIFZZ, DIFYZ, DIFXY, DIFXZ, DXXER, DYYER, DZZER, DYZER, DXYER, DXZER
        double TMAX1, DEN, AVE, XID, X, Y, Z, DFLER, DFTER, TGAS, ALPP, ATTP, SSTMIN, VDOUT, VDERR, WSOUT, WSERR, DLOUT, DLERR, NMAXOLD, DTOUT, DTERR, ALPHSST
        double ATTOINT, ATTERT, AIOERT, ALPHERR, ATTSST, TTOT, ATTERR, IZFINAL, RALPHA, RALPER, TODENE, TOFENER, TOFENE, TOFWV, TOFWVER, TOFDL, TOFDLER, TOFDT, TOFDTER, TOFWR, TOFWRER, RATTOF, RATOFER, ALPHAST, VDST, TSTEP, ZSTEP, TFINAL, RATTOFER, ZFINAL, ITFINAL, IPRIM
        double TOFWVZ, TOFWVZER, TOFWVX, TOFWVXER, TOFWVY, TOFWVYER, TOFDZZ, TOFDZZER, TOFDXX, TOFDXXER, TOFDYY, TOFDYYER, TOFDYZ, TOFDYZER, TOFDXZ, TOFDXZER, TOFDXY, TOFDXYER, TOFWRZ, TOFWRZER, TOFWRY, TOFWRYER, TOFWRX, TOFWRXER, ATTOION, ATTIOER, ATTATER
        double CONST1, CONST2, CONST3, CONST4, CONST5, TCFMX, ITHRM, CORR, FAKEI, AN, VAN, ZTOT, ZTOTS, ST, RSTART
        long long NGAS, NSTEP, NANISO, IPEN, NISO, IELOW, NCOLM, NCORLN, NCORST, NNULL, IFAKE, ITMAX, NSCALE
        double NESST[9], DENSY[4000], SPEC[4000], TIME[300], ICOLL[6][5], ICOLNN[6][10], ICOLN[6][290], ESPL[8], XSPL[8], TMSPL[8], TTMSPL[8], RSPL[8], RRSPL[8], RRSPM[8], YSPL[8], ZSPL[8], TSPL[8], XXSPL[8], YYSPL[8], ZZSPL[8], VZSPL[8], TSSUM[8], TSSUM2[8]
        double XS[2000], YS[2000], ZS[2000], TS[2000], DCX[2000], DCY[2000], DCZ[2000], IPL[2000], ETPL[8], XTPL[8], YTPL[8], ZTPL[8], YZTPL[8], XZTPL[8], XYTPL[8], VYTPL[8], VXTPL[8], TTPL[8], XXTPL[8], YYTPL[8], ZZTPL[8], VZTPL[8], NETPL[8], ZPLANE[8]
        double XSS[2000], YSS[2000], ZSS[2000], TSS[2000], ESS[2000], DCXS[2000], DCYS[2000], DCZS[2000], IPLS[2000], AMGAS[6], VTMB[6], TCFMXG[6], NGASN[6], FRAC[6], ANN[6], VANN[6], RI[8], EPT[8], VZPT[8], TTEST[8]
        double QELM[4000], QSUM[4000], QEL[4000], QSATT[4000], ES[4000], E[4000], EROOT[4000], QTOT[4000], QREL[4000], QINEL[4000], FCION[4000], FCATT[4000], IFAKET[8], IFAKED[9], RNMX[6], LAST[6], NIN[6], LION[6], ALION[6], IPLAST[6], ISIZE[6], TCFMAX[6], NPLAST[6]
        double INDEX[6][290], NC0[6][290], EC0[6][290], NG1[6][290], EG1[6][290], NG2[6][290], EG2[6][290], WKLM[6][290], EFL[6][290], EIN[6][290], IARRY[6][290], RGAS[6][290], IPN[6][290], WPL[6][290], QION[6][4000], QIN[6][250][4000], LIN[6][250], ALIN[6][250], CF[6][4000][290], TCF[6][4000], PENFRA[6][3][290], CFN[6][4000][10], TCFN[6][4000], SCLENUL[6][10], PSCT[6][4000][290], ANGCT[6][4000][290]
        double EMTY[182], ETY[153], EATY[182], EMTX[182], ETX[153], EATX[182],A,B,C,Org,DTOVMB,DTMN,DFTER1,DLOVMB,DLMN,DFLER1
        double PIR2
