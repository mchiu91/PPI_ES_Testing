#!/bin/bash

task=SOCIAL
run=$1
subj=$2

basedir=`pwd`
cd ..
MAINDATADIR=`pwd`/data
MAINOUTPUTDIR=`pwd`/outputs
cd $basedir

#datadir=/home/tue90350/data/186_Subjects_${task}/$subj/${subj}_3T_tfMRI_${task}_preproc/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}

OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_Act
DATA=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/smoothing.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz
NVOLUMES=`fslnvols ${DATA}`
rm -rf ${OUTPUT}.feat

#EV files
EVMENTAL=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/mental.txt-
EVRND=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/rnd.txt

#find and replace: run feat for smoothing
ITEMPLATE=${basedir}/templates/L1SocialAct.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_Act.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
-e 's@EVFEAR@'$EVFEAR'@g' \
-e 's@EVNEUT@'$EVNEUT'@g' \
<$ITEMPLATE> $OTEMPLATE
feat ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_Act.fsf


#delete unused files
#rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz
