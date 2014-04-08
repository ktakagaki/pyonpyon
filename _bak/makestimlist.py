"""
versuch zumindes im Ansatz eine gellerlist zu erstellen. 
nicht mehr als 3 in a row (Verhaeltnis wie Hasomedlist)
man Afang und am Ende mind eine 3 list
es werden je 20 Bloecke erzeugt, gilt also innerhalb einer 20 List

Alg: es werden die Anzahl der Bloecke: 3,2 1 vorgegben, die Reihenfolge wird dann  vertauscht
es gibt 2,2,2, d.h 2 Einzer , 2 Doppel und 2 Dreier
diese sind 2*1+2*2+2*3=12 Stimuli. fuer Go und NoGo sind das 24. 
dann diese 24 wiederholen 4x das sind 96 stimuli

"""

import numpy as np

 # 0 is GO
 # 1 ist NoGo

#ein Dreiher muss vorn und einer hinten sein
# fang mit 2 Go an
single_go=[0]
single_nogo=[1]
double_go=[0,0]
double_nogo=[1,1]
triple_go=[0,0,0]
triple_nogo=[1,1,1]

go_counter=np.array([2,2,2])
nogo_counter=np.array([2,2,2])

triallist=[]

ll=[]
# lfdr
lfdnr=0

while True:
    
    
    print lfdnr
    print 'go_counter  ',
    print go_counter
    bool_gotriple=False
    
    # starte mit go#######################
    # nur die, in denen der counter noch nicht null ist
    
    ix =np.flatnonzero(go_counter>0) 
    # ziehe aus ix
    
    # some forces, start with a double go
    if lfdnr==0:
        rindex=1
        
    elif lfdnr==1: #dann in der ersten Haelfte  ein triple
        rindex=2
    
    elif lfdnr==3:
        rindex=np.flatnonzero(ix==2)[0] # die 2 suchen, da ix keine double oder single hier enthalten kann
        #print 'lfdnr==4',
        #print go_counter
        #print ix
    else:
        rindex=np.random.randint(len(ix),high=None) # low is here the high limit, as high=None, so [0,low)

    
    if lfdnr < 3 and go_counter[2]<2: # kein weiters triple in der 1. Haelfte
        if rindex==2:
            rindex=1 # replace by double
    
    if ix[rindex]==0: # single
        triallist.append(single_go)
        ll.extend(single_go)
        go_counter[0]=go_counter[0]-1
    elif ix[rindex]==1: # double
        triallist.append(double_go)
        ll.extend(double_go)
        go_counter[1]=go_counter[1]-1
    elif ix[rindex]==2: # triple 
        triallist.append(triple_go)
        ll.extend(triple_go)
        go_counter[2]=go_counter[2]-1
        bool_gotriple=True # avoid 2 triples in of go and nogo in a row in the 2nd half og the 24 series
    else:
        print 'error'
    
    # das gleiche fuer NoGo    ##############################
    ix =np.flatnonzero(nogo_counter>0) 
    
    if lfdnr==0:
        rindex=1
    elif lfdnr==1: #dann in der ersten Haelfte  ein triple
        rindex=2

    else:
        rindex=np.random.randint(len(ix),high=None) # low is here the high limit, as high=None, so [0,low)

        
    if lfdnr < 3 and nogo_counter[2]<2: # kein weiters triple in der 1. Haelfte
        if rindex==2:
            rindex=1 # replace by double        
    
    if nogo_counter[2]==1 and bool_gotriple: # avoid 2 triples in teh 2nd half of teh 24 series
        if rindex==2:
            rindex=0 # replace by single        
        
    if ix[rindex]==0: # single
        triallist.append(single_nogo)
        ll.extend(single_nogo)
        nogo_counter[0]=nogo_counter[0]-1
    elif ix[rindex]==1: # double
        triallist.append(double_nogo)
        ll.extend(double_nogo)
        nogo_counter[1]=nogo_counter[1]-1
    elif ix[rindex]==2: # triple 
        triallist.append(triple_nogo)
        ll.extend(triple_nogo)
        nogo_counter[2]=nogo_counter[2]-1
    else:
        print 'error'
     
    
        
    
    if np.sum(go_counter)==0:   # wenn all 0 sind
        print 'go_counter  break',
        print go_counter
        break

    lfdnr=lfdnr+1
    
    
print triallist    
print len(ll)
print ll
#print np.array(triallist).flatten()
#


responsesinglealt=np.array([0,1]*12)
responsedoublealt=np.array([0,0,1,1]*6)
a=np.array(ll)
r1= a-responsesinglealt
r2= a-responsedoublealt

print len(np.flatnonzero(r1==0))/np.float(len(r1))
print len(np.flatnonzero(r2==0))/np.float(len(r2))



#np.savetxt('list.txt',ll)

