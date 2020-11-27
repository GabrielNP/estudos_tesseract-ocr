#!/bin/zsh
lang=$1

if [ -z "$1" ]
  then
    echo "No argument supplied in generate_training_data.sh"
    exit
fi


declare -a FONTLIST=('Changa Light' 
                'Kontrapunkt Light' 
                'Lucida Console Semi-Condensed' 
                'Lucida Sans Unicode Regular' 
                'Merchant Copy Regular' 
                'Monaco Regular'
                'OCR-A Regular'
                'Roboto Condensed'
                'Ubuntu Light'
                'Yanone Kaffeesatz Regular'
                )
rm -Rf train-$lang
OMP_THREAD_LIMIT=8  tesstrain.sh --fonts_dir ../fonts \
        --fontlist $FONTLIST \
        --lang $lang \
        --linedata_only \
        --langdata_dir langdata_lstm \
        --tessdata_dir tesseract/tessdata \
        --save_box_tiff \
        --maxpages 500 \
        --output_dir train-$lang

echo "\nGenerating BOX, TIF and LSTMF files"