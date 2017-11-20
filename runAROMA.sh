#!/bin/bash

basedir=`pwd`
cd ..
MAINDATADIR=/s3/hcp
MAINOUTPUTDIR=`pwd`/Analysis
cd $basedir

task=$1
run=$2
subj=$3

datadir=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}
OUTPUTDIR=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}

mkdir -p $OUTPUTDIR
OUTPUT=${OUTPUTDIR}/smoothing
DATA=${datadir}/tfMRI_${task}_${run}.nii.gz
NVOLUMES=`fslnvols ${DATA}`
aromaoutput=${OUTPUT}.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz


        #delete old output to avoid +.feat directories
        rm -rf ${OUTPUT}.feat

        #find and replace: run feat for smoothing
        TEMPLATE=${basedir}/templates/prep_aroma.fsf
        sed -e 's@OUTPUT@'$OUTPUT'@g' \
        -e 's@DATA@'$DATA'@g' \
        -e 's@NVOLUMES@'$NVOLUMES'@g' \
        <$TEMPLATE> ${OUTPUTDIR}/prep_aroma.fsf

        #Runs smoothing for WM tasks only since they were not smoothed in first batch
        feat ${OUTPUTDIR}/prep_aroma.fsf

        #create variables for ICA AROMA and run it
        myinput=${OUTPUT}.feat/filtered_func_data.nii.gz
        myoutput=${OUTPUT}.feat/ICA_AROMA
        mcfile=${OUTPUTDIR}/motion_6col.txt
        rawmotion=${datadir}/Movement_Regressors.txt


        #deleting any preexisting files
        rm -rf $myoutput
        python splitmotion.py $rawmotion $mcfile

        #running AROMA
        python ${basedir}/ICA-AROMA-master/ICA_AROMA_Nonormalizing.py -in $myinput -out $myoutput -mc $mcfile

