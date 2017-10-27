#!/bin/bash

task=WM
run=$1
subj=$2

basedir=`pwd`
cd ..
MAINDATADIR=`pwd`/data
MAINOUTPUTDIR=`pwd`/outputs
cd $basedir

#datadir=/home/tue90350/data/186_Subjects_${task}/$subj/${subj}_3T_tfMRI_${task}_preproc/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}

#datadir=${basedir}/data/186_Subjects_${task}/$subj/${subj}_3T_tfMRI_${task}_preproc/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}

OUTPUT=${datadir}/L1_WM_Act
DATA=${datadir}/smoothing.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz
NVOLUMES=`fslnvols ${DATA}`
rm -rf ${OUTPUT}.feat

#EV files
EVDIR=${datadir}/EVs
EV0BACKBODY=${EVDIR}/0bk_body
EV0backfaces=${EVDIR}/0bk_faces
EV0backplaces=${EVDIR}/0bk_places
EV0backtools=${EVDIR}/0bk_tools

EV2backbody=${EVDIR}/2bk_body
EV2backfaces=${EVDIR}/2bk_faces
EV2backplaces=${EVDIR}/2bk_places
EV2backtools=${EVDIR}/2bk_tools

#find and replace: run feat for smoothing
ITEMPLATE=${basedir}/templates/L1_WM_Act.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/smoothing.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
-e 's@EVDIR@'$EVDIR'@g' \
-e 's@EV0BACKBODY'$EV0BACKBODY'@g'\
-e 's@EV0backfaces'$EV0backfaces'@g'\
-e 's@EV0backplaces'$EV0backplaces'@g'\
-e 's@EV0backtools'$EV0backtools'@g'\

<$ITEMPLATE> $OTEMPLATE
feat $OTEMPLATE

#delete unused files
#rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz
