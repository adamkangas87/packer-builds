#!/bin/bash
echo " ==> Running Specific OS Scripts"
cd /scripts
count=`ls -1 *.sh 2>/dev/null | wc -l`
if [ $count != 0 ]
then 
for f in *.sh; do
  bash "$f" 
done
fi 

