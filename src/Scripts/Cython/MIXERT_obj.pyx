from libc.string cimport memset

cdef class MIXERT_obj:
    def __init__(self):
        memset(self.NIN, 0, 6 * sizeof(int))
        memset(self.NATT, 0, 6 * sizeof(int))
        memset(self.NNULL, 0, 6 * sizeof(int))
        memset(self.NION, 0, 6 * sizeof(int))
        memset(self.Q, 0, 6 * 6 * 4000 * sizeof(double))
        memset(self.QIN, 0, 6 * 250 * 4000 * sizeof(double))
        memset(self.E, 0, 6 * 6 * sizeof(double))
        memset(self.EIN, 0, 6 * 250 * sizeof(double))
        memset(self.KIN, 0, 6 * 250 * sizeof(double))
        memset(self.QION, 0, 6 * 30 * 4000 * sizeof(double))
        memset(self.PEQION, 0, 6 * 30 * 4000 * sizeof(double))
        memset(self.EION, 0, 6 * 30 * sizeof(double))
        memset(self.EB, 0, 6 * 30 * sizeof(double))
        memset(self.PEQEL, 0, 6 * 6 * 4000 * sizeof(double))
        memset(self.PEQIN, 0, 6 * 250 * 4000 * sizeof(double))
        memset(self.KEL, 0, 6 * 6 * sizeof(double))
        memset(self.PENFRA, 0, 6 * 3 * 290 * sizeof(double))
        memset(self.NC0, 0, 6 * 30 * sizeof(double))
        memset(self.EC0, 0, 6 * 30 * sizeof(double))
        memset(self.WK, 0, 6 * 30 * sizeof(double))
        memset(self.EFL, 0, 6 * 30 * sizeof(double))
        memset(self.NG1, 0, 6 * 30 * sizeof(double))
        memset(self.EG1, 0, 6 * 30 * sizeof(double))
        memset(self.NG2, 0, 6 * 30 * sizeof(double))
        memset(self.EG2, 0, 6 * 30 * sizeof(double))
        memset(self.SCLN, 0, 6 * 10 * sizeof(double))
        memset(self.QATTT, 0, 6 * 8 * 4000 * sizeof(double))
        memset(self.QNULL, 0, 6 * 10 * 4000 * sizeof(double))
