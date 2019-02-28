from Magboltz cimport Magboltz


cimport cython
@cython.cdivision(True)
@cython.boundscheck(False)
@cython.wraparound(False)
cdef double* COLF(Magboltz object):

    cdef double COLL[30],NINEL,NELA,NATT,NION,NTOTAL,NREAL,DUM[6]
    cdef int k,I, J
    k = 0
    for I in range(6):
        for J in range(5):
            COLL[k] = object.ICOLL[I][J]
            k += 1
    NINEL = COLL[3] + COLL[4] + COLL[8] + COLL[9] + COLL[13] + \
            COLL[14] + COLL[18] + COLL[19] + COLL[23] + COLL[24] + \
            COLL[28] + COLL[29]
    NELA = COLL[0] + COLL[5] + COLL[10] + COLL[15] + COLL[20] + \
           COLL[25]
    NATT = COLL[2] + COLL[7] + COLL[12] + COLL[17] + COLL[22] + \
           COLL[27]
    NION = COLL[1] + COLL[6] + COLL[11] + COLL[16] + COLL[21] + \
           COLL[26]
    NTOTAL = NELA + NATT + NION + NINEL
    if object.TTOTS == 0:
        NREAL = NTOTAL
        object.TTOTS = object.ST
    else:
        NREAL = NTOTAL

    DUM[5] = NTOTAL
    DUM[0] = float(NREAL) / object.TTOTS
    DUM[4] = float(NINEL) / object.TTOTS
    DUM[1] = float(NELA) / object.TTOTS
    DUM[2] = float(NION) / object.TTOTS
    DUM[3] = float(NATT) / object.TTOTS
    return DUM
