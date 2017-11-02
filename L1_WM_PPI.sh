#!/bin/bash

task=WM
run=$1
subj=$2

basedir=`pwd`
cd ..
MAINDATADIR=`pwd`/data
MAINOUTPUTDIR=`pwd`/outputs
cd $basedir

OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_WM_PPI
DATA=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/smoothing.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz
NVOLUMES=`fslnvols ${DATA}`
rm -rf ${OUTPUT}.feat

#EV files
EVDIR=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs

ZBKBODY=${EVDIR}/0bk_body.txt
ZBKFACE=${EVDIR}/0bk_faces.txt
ZBKPLACE=${EVDIR}/0bk_places.txt
ZBKTOOL=${EVDIR}/0bk_tools.txt

TBKBODY=${EVDIR}/2bk_body.txt
TBKFACE=${EVDIR}/2bk_faces.txt
TBKPLACE=${EVDIR}/2bk_places.txt
TBKTOOL=${EVDIR}/2bk_tools.txt

#generate mask's timecourse
MASK=${basedir}/Masks/rT1_Amygdala_Seed.nii
TIMECOURSE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/my_timecourse.txt
fslmeants -i $DATA -o $TIMECOURSE -m $MASK

#find and replace: run feat for smoothing
ITEMPLATE=${basedir}/templates/L1_WM_PPI.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/smoothing.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
-e 's@EVDIR@'$EVDIR'@g' \

-e 's@ZBKBODY'$ZBKBODY'@g'\
-e 's@ZBKFACE'$ZBKFACE'@g'\
-e 's@ZBKPLACE'$ZBKPLACE'@g'\
-e 's@ZBKTOOL'$ZBKTOOL'@g'\

-e 's@TBKBODY'$TBKBODY'@g'\
-e 's@TBKFACE'$TBKFACE'@g'\
-e 's@TBKPLACE'$TBKPLACE'@g'\
-e 's@TBKTOOL'$TBKTOOL'@g'\

<$ITEMPLATE> $OTEMPLATE
feat $OTEMPLATE

#delete unused files
#rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz
