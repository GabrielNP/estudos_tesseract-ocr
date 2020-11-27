#!/bin/zsh
if [ -z "$1" ]
  then
    echo "No argument supplied in combine.sh"
    exit
fi

lang=$1

echo "\Finish creating new training model..."

OMP_THREAD_LIMIT=8 lstmtraining --stop_training \
    --continue_from output-$lang/${lang}_checkpoint \
    --traineddata tesseract/tessdata/$lang.traineddata \
    --model_output output-$lang/$lang.traineddata