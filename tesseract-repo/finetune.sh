#!/bin/zsh
if [ -z "$1" ]
  then
    echo "No argument supplied in finetune.sh"
    exit
fi

lang=$1

echo "\nFine tuning..."

OMP_THREAD_LIMIT=8 lstmtraining \
    --continue_from $lang.lstm \
    --model_output output-$lang/$lang \
    --traineddata tesseract/tessdata/$lang.traineddata \
    --train_listfile train-$lang/$lang.training_files.txt \
    --max_iterations 2000