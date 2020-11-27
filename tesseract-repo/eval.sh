OMP_THREAD_LIMIT=8 lstmeval --model output-por/por_checkpoint \
    --traineddata tesseract/tessdata/por.traineddata \
    --eval_listfile train-por/por.training_files.txt