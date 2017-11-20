#!/bin/bash

task=SOCIAL
run=$1
subj=$2

basedir=`pwd`
cd ..
MAINDATADIR=`pwd`/data
MAINOUTPUTDIR=`pwd`/outputs
cd $basedir

OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_NetworkPPI
DATA=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_Act.feat/filtered_func_data.nii.gz
NVOLUMES=`fslnvols ${DATA}`

#remove if output file exists
if [ -e ${OUTPUT}.feat ]; then
  rm -rf ${OUTPUT}.feat
fi

#EV files
EVMENTAL=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/mental.txt
EVRND=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/rnd.txt

#generate mask's timecourse
MASK=${basedir}/Masks/rT1_vPAC_Seed.nii
TIMECOURSE=$OUTPUT/dr_stage1_${subj}.txt
#fslmeants -i $DATA -o $TIMECOURSE -m $MASK
$FSLDIR/bin/fsl_glm -i $DATA -d $ICA_MAPS -o $OUTPUT/dr_stage1_${subj}.txt --demean -m $OUTPUT/mask
#$FSLDIR/bin/fsl_glm -i $i -d $OUTPUT/dr_stage1_${s}.txt -o $OUTPUT/dr_stage2_$s --out_z=$OUTPUT/dr_stage2_${s}_Z --demean -m $OUTPUT/mask $DES_NORM

#find and replace: run feat for smoothing
ITEMPLATE=${basedir}/templates/L1SocialAct.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_PPI.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
-e 's@EVMENTAL@'$EVMENTAL'@g' \
-e 's@EVRND@'$EVRND'@g' \
-e 's@TIMECOURSE@'$TIMECOURSE'@g' \
<$ITEMPLATE> $OTEMPLATE
feat $OTEMPLATE

#delete unused files
#rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz
