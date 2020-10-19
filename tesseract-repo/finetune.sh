rm -Rf output/*
OMP_THREAD_LIMIT=8 lstmtraining \
    --continue_from por.lstm \
    --model_output output/courier \
    --traineddata tesseract/tessdata/por.traineddata \
    --train_listfile train/por.training_files.txt \
    --max_iterations 2000
