#!/bin/zsh
lang=$1

if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit
fi

echo "\nRunning OCR to '$lang' language"

./extract_lstm.sh $lang

./generate_training_data.sh $lang

./finetune.sh $lang

./combine.sh $lang

cp -f output-$lang/$lang.traineddata tesseract/tessdata
sudo mv -f output-$lang/$lang.traineddata $TESSDATA_PREFIX