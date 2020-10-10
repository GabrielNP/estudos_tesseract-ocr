# Configuração e execução
1) Clonar os repositórios

    git clone https://github.com/tesseract-ocr/tesseract

    git clone https://github.com/tesseract-ocr/langdata_lstm

2) Na pasta /tesseract/tessdata salvar os arquivos `.traineddata` do idioma desejado.

    ```
    // Parecem ser obrigatórios para o bom funcionamento
    wget https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata
    wget https://github.com/tesseract-ocr/tessdata/raw/master/osd.traineddata

    // Idioma desejado
    wget https://github.com/tesseract-ocr/tessdata_best/raw/master/por.traineddata
    ```

3) Executar `generate_training_data`

    ```
    // Garante que seja executável
    chmod a+x generate_training_data

    ./generate_training_data
    ```

4) Executar `extract_lstm.sh` para extrair o modelo do arquivo traineddata que baixamos a fim de que possamos avaliá-lo.

    ```
    // Garanta que seja executável
    chmod a+x extract_lstm.sh

    ./extract_lstm.sh
    ```

    O arquivo `por.lstm` foi gerado.

5) Executar `eval.sh` para avaliar o modelo recém extraído (no passo 4) utilizando os melhores dados de treinamento (do passo 2). O último parâmetro é o arquivo gerado pelo passo 3 (por conta do parâmetro save_box_tif)

    ```
    // Garanta que seja executável
    chmod a+x eval.sh

    ./eval.sh
    ```

6) Para melhorar a precisão

    6.1. Crie a pasta output

    ```
    mkdir output
    ```

    6.2. Execute `finetune.sh`

    ```
    // Garanta que seja executável
    chmod a+x finetune.sh

    ./finetune.sh
    ```

    6.3. Executar `combine.sh` . Nessa etapa é mesclado o último checkpoint de treinamento da fonte em questão com o melhor modelo de treinamento (do passo 2) e é gerado a partir deles um novo modelo que pode ser usado nas futuras detecções de texto.

    ```
    // Garante que seja executável
    chmod a+x combine.sh

    ./combine.sh
    ```

7) Avaliando o modelo refinado. Executar `eval2.sh`, que é basicamente uma cópia de eval.sh mas utilizando como parâmetro o modelo recém gerado ao invés do extraído (no passo 3) do modelo de treinamento padrão.

    ```
    // Garanta que seja executável
    chmod a+x eval2.sh

    ./eval2.sh
    ```

    Percebe-se que a taxa de erro diminuiu.

# Referências e agradecimentos
- Vídeo [Training/Fine Tuning Tesseract OCR LSTM for New Fonts](https://www.youtube.com/watch?v=TpD76k2HYms&t=215s) do Gabriel Garcia
- https://tesseract-ocr.github.io/tessdoc/TrainingTesseract-4.00.html
- toda a comunidade colaborativa na internet