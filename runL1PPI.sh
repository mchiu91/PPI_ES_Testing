#!/bin/bash

#for task in Emo Soc WM; do
for task in WM; do
  dos2unix L1_${task}_PPI.sh

  #for subj in `cat sublist`; do
  for subj in 100307; do
    bash L1_${task}_PPI.sh LR $subj &

    sleep 5s

    bash L1_${task}_PPI.sh RL $subj
  done
done
