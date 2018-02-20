#!/bin/bash

# pliki wymagajace przetworzenia powinny
# znajdowac sie w katalogu 'dane'

pliki=`ls dane/*cmax`

for i in $pliki

do
echo $i

cp $i tmp.cmax # tworzenie pliku tymczasowego

time ./RainBlob -expand tmp.cmax # 'rozpakowanie' bloba z XML do formy binarnej i sprawdzenie czasu operacji

 echo -e "jestem po RainBlobie"

sleep 3

numery=`grep -an BLOB  tmp.cmax |  sed 's/:/ /g'| awk '{print $1}' `


nr1=`echo $numery | awk '{print $1}'`
nr2=`echo $numery | awk '{print $2}'`
nr3=`echo $numery | awk '{print $3}'`
nr4=`echo $numery | awk '{print $4}'`

nr1=$[$nr1+1]
nr3=$[$nr3+1]
nr2=$[$nr2-1]
nr4=$[$nr4-1]


fileout=`echo $i | tr '/' '_' | sed 's/dane_//g' `
echo $fileout

sed "$nr1,$nr2 !d" tmp.cmax > blob1.$fileout
sed "$nr3,$nr4 !d" tmp.cmax > blob2.$fileout

done


