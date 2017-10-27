#!/bin/bash

task=EMOTION
run=$1
subj=$2

basedir=`pwd`
cd ..
MAINDATADIR=`pwd`/data
MAINOUTPUTDIR=`pwd`/outputs
cd $basedir

#datadir=/home/tue90350/data/186_Subjects_${task}/$subj/${subj}_3T_tfMRI_${task}_preproc/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}

OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Emotion_PPI
DATA=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/smoothing.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz
NVOLUMES=`fslnvols ${DATA}`
rm -rf ${OUTPUT}.feat

#EV files
EVFEAR=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/fear.txt
EVNEUT=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/neut.txt

MASK=${basedir}/Masks/rT1_Amygdala_Seed.nii

#place mask in folder
#cp $MASK

#generate mask's timecourse
TIMECOURSE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/my_timecourse.txt
fslmeants -i $DATA -o $TIMECOURSE -m $MASK

#find and replace: run feat for smoothing
ITEMPLATE=${basedir}/templates/L1_EMO_PPI.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Emotion_PPI.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
-e 's@EVFEAR@'$EVFEAR'@g' \
-e 's@EVNEUT@'$EVNEUT'@g' \
-e 's@TIMECOURSE@'$TIMECOURSE'@g' \
<$ITEMPLATE> $OTEMPLATE
feat $OTEMPLATE

#delete unused files
#rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz
