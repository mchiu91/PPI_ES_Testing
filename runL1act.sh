#!/bin/bash

#for task in WM Soc Emo; do
for task in WM; do
  dos2unix L1_${task}_Act.sh

  for subj in 100307 100408 100610 101006; do
    bash L1_${task}_Act.sh LR $subj &

    sleep 5s

    bash L1_${task}_Act.sh RL $subj
  done
done
