# Configurações iniciais
 
1. Garanta que os recursos abaixo estão instalados.

    ```
    sudo apt-get install tesseract-ocr libtesseract-dev
    ```

2. Exporte a variável de ambiente TESSDATA_PREFIX
    
    Identifique qual shell está em uso para saber onde salvar a variável de ambiente.
    ```
    echo $SHELL
    ```
    Resultado: `/usr/bin/zsh` . Portanto o shell usado é `zsh`.

    ```
    echo "export TESSDATA_PREFIX='/usr/share/tesseract-ocr/4.00/tessdata'" >> ~/.zshrc
    ```


# Treinamento
1) Clonar os repositórios

    git clone https://github.com/tesseract-ocr/tesseract

    git clone https://github.com/tesseract-ocr/langdata_lstm

2) Na pasta /tesseract/tessdata salvar os arquivos `.traineddata` do idioma desejado.

    ```bash
    # São obrigatórios
    wget https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata
    wget https://github.com/tesseract-ocr/tessdata/raw/master/osd.traineddata

    # Idioma desejado (Ex: portuguese)
    wget https://github.com/tesseract-ocr/tessdata_best/raw/master/por.traineddata
    ```

3) Executar `generate_training_data`

    ```bash
    # Garanta que seja executável
    chmod a+x generate_training_data

    ./generate_training_data
    ```

4) Executar `extract_lstm.sh` para extrair o modelo do arquivo traineddata que baixamos a fim de que possamos avaliá-lo.

    ```bash
    # Garanta que seja executável
    chmod a+x extract_lstm.sh

    ./extract_lstm.sh
    ```

    O arquivo `por.lstm` foi gerado.

5) Executar `eval.sh` para avaliar o modelo recém extraído (no passo 4) utilizando os melhores dados de treinamento (do passo 2). O último parâmetro é o arquivo gerado pelo passo 3 (por conta do parâmetro save_box_tif)

    ```bash
    # Garanta que seja executável
    chmod a+x eval.sh

    ./eval.sh
    ```

6) Para melhorar a precisão

    6.1. Crie a pasta output

    ```
    mkdir output
    ```

    6.2. Execute `finetune.sh`

    ```bash
    # Garanta que seja executável
    chmod a+x finetune.sh

    ./finetune.sh
    ```

    6.3. Executar `combine.sh` . Nessa etapa é mesclado o último checkpoint de treinamento da fonte em questão com o melhor modelo de treinamento (do passo 2) e é gerado a partir deles um novo modelo que pode ser usado nas futuras detecções de texto.

    ```bash
    # Garanta que seja executável
    chmod a+x combine.sh

    ./combine.sh
    ```

7) Avaliando o modelo refinado. Executar `eval2.sh`, que é basicamente uma cópia de eval.sh mas utilizando como parâmetro o modelo recém gerado ao invés do extraído (no passo 3) do modelo de treinamento padrão.

    ```bash
    # Garanta que seja executável
    chmod a+x eval2.sh

    ./eval2.sh
    ```

    Percebe-se que a taxa de erro diminuiu.

# Transcrição

1. Preparando o ambiente

    Copie os arquivos de modelo treinados para o diretório `$TESSDATA_PREFIX` e substitua os modelos de mesmo idioma lá existentes.

    Caso não tenha treinado, execute os comandos do passo 2) de [Treinamento](#treinamento) dentro do diretório `$TESSDATA_PREFIX`.

2. Execução

    O Tesseract OCR pode:

    2.1 ser executado com o próprio comando tesseract. Exemplo:

    ```bash
    # onde:
    # <imagem> é o caminho até a imagem
    # <output> é o arquivo para gravar a transcrição; para somente exibir no terminal usar "stdout" (sem aspas)

    # Parâmetros recomendados:
    # -l <lang> , onde <lang> é o idioma desejado 
    # --psm 6
    # --dpi 300

    tesseract <imagem> <ouput ou stdout> -l <lang> --dpi 300 --psm 6
    ```

    2.2 Ou também pode ser utilizado em um código Python com a biblioteca `pytesseract`. Para seguir a implementação desse tutorial siga as instruções abaixo.

    2.2.1 Configure o ambiente virtual

    ```
    python3 -m venv .venv
    ```
    2.2.2. Ative-o
    ```
    source .venv/bin/activate
    ```
    2.2.3 Instale as bibliotecas terceiras
    ```
    pip install -r requirements.txt
    ```
    2.2.4 Garanta que seja executável
    ```
    chmod a+x transcript.py
    ```
    2.2.5 Execute
    ```bash
    # Parâmetro 1 => idioma
    # Parâmetro 2 => modo de execução: single ou bulk

    # Necessário indicar no arquivo abaixo, dentro da função do_ocr(), o caminho e o nome da(s) imagem(ns)  a ser(em) transcrita(s)

    ./transcript.py <param1> <param2>
    ```

# Referências e agradecimentos
- Vídeo [Training/Fine Tuning Tesseract OCR LSTM for New Fonts](https://www.youtube.com/watch?v=TpD76k2HYms&t=215s) do Gabriel Garcia
- [Documentação oficial](https://tesseract-ocr.github.io/tessdoc/TrainingTesseract-4.00.html)
- toda a comunidade colaborativa na internet