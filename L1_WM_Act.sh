#!/bin/bash

task=WM
run=$1
subj=$2

basedir=`pwd`
datadir=/home/tue90350/data/186_Subjects_${task}/$subj/${subj}_3T_tfMRI_${task}_preproc/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}

#datadir=${basedir}/data/186_Subjects_${task}/$subj/${subj}_3T_tfMRI_${task}_preproc/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}

OUTPUT=${datadir}/L1_WM_Act
DATA=${datadir}/smoothing.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz
NVOLUMES=`fslnvols ${DATA}`
rm -rf ${OUTPUT}.feat

#EV files
EVDIR=${datadir}/EVs
0BACKBODY=${EVDIR}/0bk_body
0backfaces=${EVDIR}/0bk_faces
0backplaces=${EVDIR}/0bk_places
0backtools=${EVDIR}/0bk_tools

2backbody=${EVDIR}/2bk_body
2backfaces=${EVDIR}/2bk_faces
2backplaces=${EVDIR}/2bk_places
2backtools=${EVDIR}/2bk_tools

#find and replace: run feat for smoothing
TEMPLATE=${basedir}/templates/L1_WM_Act.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
-e 's@EVDIR@'$EVDIR'@g' \
-e 's@0BACKBODY'$0BACKBODY'@g'\
-e 's@0backfaces'$0backfaces'@g'\
-e 's@0backplaces'$0backplaces'@g'\
-e 's@0backtools'$0backtools'@g'\

<$TEMPLATE> ${datadir}/L1_WM_Act.fsf
feat ${datadir}/L1_WM_Act.fsf

#delete unused files
#rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz
