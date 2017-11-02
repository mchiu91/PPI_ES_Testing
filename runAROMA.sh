#!/bin/bash

basedir=`pwd`
cd ..
MAINDATADIR=`pwd`/data
MAINOUTPUTDIR=`pwd`/outputs
cd $basedir



#for task in EMOTION SOCIAL WM; do
for task in WM; do
  for run in LR RL; do
    #for subj in `cat sublist`; do
    for subj in 100307 100408; do
      #fix paths to reflect lab structure
      datadir=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}
      OUTPUTDIR=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}

      mkdir -p $OUTPUTDIR

      OUTPUT=${OUTPUTDIR}/smoothing
      DATA=${datadir}/tfMRI_${task}_${run}.nii.gz
      NVOLUMES=`fslnvols ${DATA}`
      aromaoutput=${OUTPUT}.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz

      #Checks if AROMA output exists; runs ICA_AROMA if it doesn't exist
      #if [ -e $aromaoutput ] ; then
        #echo "exists: $aromaoutput"
      #else

        #delete old output to avoid +.feat directories
        rm -rf ${OUTPUT}.feat

        #find and replace: run feat for smoothing
        TEMPLATE=${basedir}/templates/prep_aroma.fsf
        sed -e 's@OUTPUT@'$OUTPUT'@g' \
        -e 's@DATA@'$DATA'@g' \
        -e 's@NVOLUMES@'$NVOLUMES'@g' \
        <$TEMPLATE> ${OUTPUTDIR}/prep_aroma.fsf

        #Runs smoothing for WM tasks only since they were not smoothed in first batch
        #if [ "$task" == "WM" ]; then
          feat ${OUTPUTDIR}/prep_aroma.fsf
        #else
        #  echo "skipping feat for this $task for this $subj"
      # fi

        #create variables for ICA AROMA and run it
        myinput=${OUTPUT}.feat/filtered_func_data.nii.gz
        myoutput=${OUTPUT}.feat/ICA_AROMA
        mcfile=${OUTPUTDIR}/motion_6col.txt
        rawmotion=${datadir}/Movement_Regressors.txt


        #deleting any preexisting files
        rm -rf $myoutput
        python splitmotion.py $rawmotion $mcfile

      #fi
        #running AROMA
        python ${basedir}/ICA-AROMA-master/ICA_AROMA_Nonormalizing.py -in $myinput -out $myoutput -mc $mcfile
    done
  done
done
