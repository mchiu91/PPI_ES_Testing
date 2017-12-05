#!/bin/bash

#for task in Emo Soc WM; do
for task in Soc; do
  dos2unix L1_${task}_NetworkPPI.sh

  #for subj in `cat sublist`; do
  for subj in 100307 100408 100610 101006; do
    bash L1_${task}_NetworkPPI.sh LR $subj &

    sleep 5s

    bash L1_${task}_NetworkPPI.sh RL $subj
  done
done
