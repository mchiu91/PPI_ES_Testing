#!/bin/bash

basedir=`pwd`
cd ..
MAINDATADIR=`pwd`/Data
#MAINDATADIR=/s3/hcp
MAINOUTPUTDIR=`pwd`/outputs
cd $basedir



#for task in EMOTION SOCIAL WM; do
for task in SOCIAL; do
    for subj in `cat sublist`; do

      #controls number of jobs submitted
      SCRIPTNAME=runAROMA.sh
      NCORES=16
      while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -gt $NCORES ]; do
        sleep 1m
      done


	bash runAROMA.sh $task LR $subj &
	bash runAROMA.sh $task RL $subj



    done
done
