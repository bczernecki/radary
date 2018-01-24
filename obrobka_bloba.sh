#!/bin/bash

for i in *.cmax
do

echo $i
numery=`grep -an BLOB  $i |  sed 's/:/ /g'| awk '{print $1}' `


nr1=`echo $numery | awk '{print $1}'`
nr2=`echo $numery | awk '{print $2}'`
nr3=`echo $numery | awk '{print $3}'`
nr4=`echo $numery | awk '{print $4}'`

nr1=$[$nr1+1]
nr3=$[$nr3+1]
nr2=$[$nr2-1]
nr4=$[$nr4-1]



sed "$nr1,$nr2 !d" $i > blob1.$i
sed "$nr3,$nr4 !d" $i > blob2.$i

done


