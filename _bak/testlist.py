# -*- coding: utf-8 -*-
"""
Created on Mon Jan 13 10:30:49 2014

@author: schulza

test die liste auf einige Dinge, z.B Gellermann Sachen

"""

# to do


import numpy as np

a=np.loadtxt('as3gellermannlist.txt')



# response=
responsesinglealt=np.array([1,0]*12)
responsedoublealt=np.array([1,1,0,0]*6)

r1= a-responsesinglealt
r2= a-responsedoublealt

print len(np.flatnonzero(r1==0))/np.float(len(r1))
print len(np.flatnonzero(r2==0))/np.float(len(r2))

print a







