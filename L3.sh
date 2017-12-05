for task in Social Emotion WM; do
  for type in Act PPI nPPI_DMN nPPI_ECN; do
    while copenum < 10; do
      set feat_files(1) "/data/Analysis/*/MNINonLinear/Results/L2_${task}_${type}.gfeat/${copenum}.feat/stats/cope1.nii.gz"
    if [ ! -e /data/Analysis/*/MNINonLinear/Results/L2_${task}_${type}.gfeat/${copenum}.feat/stats/cope1.nii.gz]
      echo "Cope${copenum} does not exist."
    fi

    sed -e 's@OUTPUT@'$OUTPUT'@g' \
    -e 's@TYPE@'$TYPE'@g' \
    -e 's@NVOLUMES@'$NVOLUMES'@g' \
    done
  done
done
