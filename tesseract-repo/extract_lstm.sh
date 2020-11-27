#!/bin/zsh
if [ -z "$1" ]
  then
    echo "No argument supplied in extract_lstm.sh file"
    exit
fi

lang=$1

rm $lang.lstm
combine_tessdata -e tesseract/tessdata/$lang.traineddata $lang.lstm

echo "\nNeural network file (.LSTM) was extracted from training model for '$lang' language"