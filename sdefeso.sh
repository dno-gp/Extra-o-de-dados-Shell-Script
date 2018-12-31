#!/bin/bash

###############
#SEGURO DEFESO#
###############

echo -e Processo de extração de dados iniciado...
echo -e "Beneficiários seguro defeso (pescador artesanal)"

#baixar arquivos
echo -e "\nExecutando downloads..."
for x in $(cat periodo.txt)
do wget -c --show-progress  http://www.portaltransparencia.gov.br/download-de-dados/seguro-defeso/${x}.zip
done

#desconpactar arquivos
echo -e "\nDescompactando arquivos baixados..."
for i in $(ls *.zip)
do unzip  $i
done

#filtrar arquivos
echo -e "\nFiltrando arquivos baixados..."

touch auxiliar.txt

for i in $(ls *.csv)
do for x in $(cat munics.txt)
   do grep -iw "$x" $i > arq.txt
      cat arq.txt >> auxiliar.txt
   done
done

grep -iw 'pb' auxiliar.txt > beneficiados.csv

echo -e "\nRemovendo arquivos desnescessários..."
rm -vr arq.txt
rm -vr 201*
rm -vr auxiliar.txt

echo -e "Processo finalizado!"
