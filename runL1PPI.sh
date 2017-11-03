#!/bin/bash

#


#for task in Emo Soc WM; do
for task in Soc; do
  #for subj in `cat sublist`; do
  for subj in 100307 100408 100610 101006; do
    dos2unix L1_${task}_PPI.sh LR $subj
    bash L1_${task}_PPI.sh LR $subj &
    sleep 5s

    dos2unix L1_${task}_PPI.sh RL $subj
    bash L1_${task}_PPI.sh RL $subj

  done
done
