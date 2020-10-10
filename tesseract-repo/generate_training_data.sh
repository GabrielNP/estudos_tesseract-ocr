rm -Rf train/*
tesstrain.sh --fonts_dir fonts \
        --lang por \
        --linedata_only \
        --langdata_dir langdata_lstm \
        --tessdata_dir tesseract/tessdata \
        --save_box_tiff \
        --maxpages 10 \
        --output_dir train \
        --fontlist 'Courier Prime Regular'
        