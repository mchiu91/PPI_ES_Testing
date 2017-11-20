#!/bin/bash

basedir=`pwd`
cd ..
MAINDATADIR=/s3/hcp
MAINOUTPUTDIR=`pwd`/outputs
cd $basedir



#for task in EMOTION SOCIAL WM; do
for task in SOCIAL; do
    for subj in `cat sublist`; do
    
	bash runAROMA.sh $task LR $subj &
	bash runAROMA.sh $task RL $subj 

		

    done
done
