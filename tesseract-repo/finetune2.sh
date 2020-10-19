OMP_THREAD_LIMIT=8 lstmtraining \
    --continue_from por2.lstm \
    --model_output output/courier \
    --traineddata output/courier.traineddata \
    --train_listfile train/por.training_files2.txt\
    --max_iterations 400;