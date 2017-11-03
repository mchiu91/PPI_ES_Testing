#!/bin/bash


#for task in WM Soc Emo; do
for task in WM; do
  for subj in 100307 100408 100610 101006; do
    dos2unix L1_${task}_Act.sh LR $subj
    bash L1_${task}_Act.sh LR $subj &

    sleep 5s

    dos2unix L1_${task}_Act.sh RL $subj
    bash L1_${task}_Act.sh RL $subj
  done
done
