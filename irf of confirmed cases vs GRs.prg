
wfopen "c:\users\tony\desktop\covid-19\data used.wf1"

table (180,5) result
table (180,5) sig
 result(1,2)="lgov"
 result(1,3)="fata"
result(1,4)="case"
result(1,5)="death"
 sig(1,2)="lgov"
 sig(1,3)="fata"
sig(1,4)="case"
sig(1,5)="death"
for !i=1 to 179
   scalar l=226*(!i-1)+1
   scalar u=226*!i
  smpl  {l} {u}
   freeze(govtable) lgov.uroot
    freeze(fatatable) fata.uroot
   freeze(casetable) lcase.uroot(dif=1)
    freeze(deathtable) ldeath.uroot(dif=1)
 result(!i+1,1)=!i
  result(!i+1,2)=@val(govtable(7,5))
  result(!i+1,3)=@val(fatatable(7,5))
 result(!i+1,4)=@val(casetable(7,5))
 result(!i+1,5)=@val(deathtable(7,5))
d govtable
d fatatable
d casetable
d deathtable

next
smpl @all
for !j=1 to 179
sig(!j+1,1)=!j
if @val(result(!j+1,2))<0.1 then
   sig(!j+1,2)="+"
  else sig(!j+1,2)="-"
endif

if @val(result(!j+1,3))<0.1 then
   sig(!j+1,3)="+"
  else sig(!j+1,3)="-"
endif
if @val(result(!j+1,4))<0.1 then
   sig(!j+1,4)="+"
  else sig(!j+1,4)="-"
endif

if @val(result(!j+1,5))<0.1 then
   sig(!j+1,5)="+"
  else sig(!j+1,5)="-"
endif
next
for !k=1 to 179
   scalar l=226*(!k-1)+1
   scalar u=226*!k
   smpl  {l} {u}
 if  sig(!k+1,2)="+" and sig(!k+1,4)="+" then
   
   var vartemp1.ls 1 8  d(lcase)  lgov
   freeze(irftemp1) vartemp1.impulse(30,se=a, reps=100)  d(lcase)  @ lgov
   freeze(irftemp2) vartemp1.impulse(30,se=a, reps=100) lgov @ d(lcase)
   freeze(irf{!k}) irftemp1 irftemp2
   d irftemp1
   d irftemp2
   d vartemp1
  else
  endif
if  sig(!k+1,2)="-" and sig(!k+1,4)="-" then
   var vartemp2.ls 1 8  d(d(lcase))  d(lgov)
   freeze(irftemp3) vartemp2.impulse(30,a,se=a, reps=100)  d(d(lcase))  @ d(lgov)
   freeze(irftemp4) vartemp2.impulse(30,a, se=a, reps=100)  d(lgov) @ d(d(lcase))
   freeze(irf{!k}) irftemp3 irftemp4
   d irftemp3
   d irftemp4
   d vartemp2
 else
endif
if sig(!k+1,2)="+" and sig(!k+1,4)="-" then
  var vartemp3.ls 1 8  d(d(lcase))  lgov
   freeze(irftemp5) vartemp3.impulse(30,a,se=a, reps=100)  d(d(lcase))  @ lgov
   freeze(irftemp6) vartemp3.impulse(30, se=a, reps=100)  lgov @ d(d(lcase))
   freeze(irf{!k}) irftemp5 irftemp6
   d irftemp5
   d irftemp6
   d vartemp3
else
endif
if sig(!k+1,2)="-" and sig(!k+1,4)="+" then
  var vartemp4.ls 1 8  d(lcase)  d(lgov)
   freeze(irftemp7) vartemp4.impulse(30,se=a, reps=100)  d(lcase)  @ d(lgov)
   freeze(irftemp8) vartemp4.impulse(30,a, se=a, reps=100)  d(lgov) @ d(lcase)
   freeze(irf{!k}) irftemp7 irftemp8
   d irftemp7
   d irftemp8
   d vartemp4
 else
endif
next
smpl @all


