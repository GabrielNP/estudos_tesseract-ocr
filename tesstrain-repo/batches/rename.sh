for file in ../data/por-ground-truth/*.tif; do
    python3 rename.py $file;
    done