# Sumário
- [Dependências e libs](#dependências-e-libs)
- [Configuração](#configuração)
- [Como executar](#como-executar)
    
    * [Exemplo](#o-repositório-tesstrain-clonado-trás-um-exemplo-para-ser-testado.)
    * [Novo modelo](#um-novo-modelo)
- [Referências e agradecimentos](#referências-e-agradecimentos)

## Dependências e libs

Executar arquivo `install_dependencies_and_libs.sh` na pasta batches

## Configuração
 1) Clonar repositório tesstrain

    ```
    rm -Rf tesstrain/
    git clone https://github.com/tesseract-ocr/tesstrain.git
    ```
2) Dentro da nova pasta tesstrain

    ```
    cd tesstrain
    python3 -m venv .venv 
    source .venv/bin/activate
    pip install -r requirements.txt
    deactivate
    mv tesseract-* tesseract
    cd ..
    ```

3) Variável de ambiente TESSDATA_PREFIX
    
    Identifique qual shell está em uso para saber onde salvar a variável de ambiente.
    ```
    echo $SHELL
    ```
    Resultado: `/usr/bin/zsh` . Portanto o shell usado é `zsh`.

    ```
    echo "export TESSDATA_PREFIX='<caminho-até-a-pasta-tesstrain>/tesstrain/tesseract/tessdata'" >> ~/.zshrc
    ```
4) Na pasta tesstrain/tesseract, executar um comando após o outro:

    ```
    ./autogen.sh
    ./configure
    make
    sudo make install
    sudo ldconfig
    sudo make training
    sudo make training-install
    make leptonica tesseract
    ```

5) Na pasta tesstrain/tesseract/tessdata salvar os arquivos `.traineddata` do idioma desejado.

    ```
    // Parecem ser obrigatórios para o bom funcionamento
    wget https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata
    wget https://github.com/tesseract-ocr/tessdata/raw/master/osd.traineddata

    // Idioma desejado
    wget https://github.com/tesseract-ocr/tessdata_best/raw/master/por.traineddata
    ```

## Como executar 

### O repositório tesstrain clonado trás um exemplo para ser testado.

1) Na pasta raiz tesstrain executar:

    ```
    mkdir -p data/foo-ground-truth
    unzip ocrd-testset.zip -d data/foo-ground-truth
    make leptonica tesseract
    ```

2) Os arquivos descompactados para a pasta data/foo-ground-truth foram arquivos ground-truth (.gt.txt) e imagens (.tif). É importante que em cada par de arquivo ground-truth e imagem corresponda a uma linha de texto.

    Executar:

    ```
    make training 
    ```
    O tesseract vai gerar os arquivos `.box` e `.lstmf` dentro da pasta data/foo

3) Em seguida executar:

    ```
    make traineddata
    ```
    O tesseract vai gerar um arquivo `.traineddata` na pasta data. Este arquivo poderá ser usado como modelo em futuras detecções de OCR como se fosse um idiomna DESDE QUE ele seja copiado/movido para o diretório TESSDATA_PREFIX em questão. No caso desse tutorial no caminho: `<caminho-até-tesstrain>/tesseract/tessdata/` .

    Exemplo:

    ```
    tesseract <imagem-a-ter-texto-detectado> stdout -l foo
    ```

### Um novo modelo

1) Criar uma pasta dentro de tesstrain/data. Exemplo:

    ```
    mkdir por-ground-truth
    ```

2) Par de arquivos ground-truth e de imagem.

    Nesse momento será necessário um arquivo de texto para o qual o seu modelo vai ser criado e treinado. A partir dele o par de arquivos vai ser gerado para cada linha de texto.

    2.1. Crie / tenha o arquivo para treinamento. Exemplo: `por.training_text` em `data/por.ground-truth/`

    2.2. Execute o arquivo `split_and_stip.py` dentro do diretório (etapa acima) para que quebras de linha e espaços iniciais/finais sejam removidos.

    ```
    // Uma vez que o arquivo esteja copiado para o diretório em questão, garanta que ele seja executável
    chmod a+x split_and_stip.py

    // Execute o arquivo e passe como argumento o caminho e nome do arquivo de treinamento.
    ./split_and_stip.py por.training_text
    ```

    2.3. Foram gerados vários arquivos `gt.txt` para cada linha do arquivo de treinamento. Agora é preciso gerar uma imagem de cada arquivo `.gt.txt` . Executar o arquivo `generate_tif.sh` localizado na pasta batches.

    ANTES DE EXECUTAR é importante ressaltar que esse arquivo vai utilizar as fontes 'Courier Prime' da pasta `fonts` desse tutorial. Caso queira gerar imagens para cada fonte do seu sistema operacional Linux, altere o valor do parâmetro `fonts_dir` para `usr/share/fonts` ; ou adicione mais imagens desejadas na pasta fonts.

    ```
    // Copie o arquvivo para o diretório em questão (data/por.ground-truth) e garanta que ele esteja executável
    chmod a+x generate_tif.sh

    ./generate_tif.sh
    ```

    Ao final da execução você teá o par de arquivos ground-truth e imagem.

    2.4. É importante que os nomes dos arquivos gerados não contenham mais que 3 pontos (.). Portanto, é preciso arrumar seus nomes com `rename.sh` .

    ```
    // Em batches garanta que seja executável
    chmod a+x rename.sh

    ./rename.sh
    ```

    Este comando vai acessar a pasta gerada por-ground-truth em data e vai passar cada arquivo tif encontrado como parâmetro do código python rename.py. Dessa forma o cada arquivo .tif será renomeado para um noem mais curto sem pontos excessivos.

3) Executar:

    ```
    make leptonica tesseract
    sudo make training MODEL_NAME=por
    ```
    O tesseract vai gerar os arquivos `.box` e `.lstmf` dentro da pasta data/por

4) Se tudo ocorrer certo no passo anterior, execute:

    ```
    sudo make traineddata
    ```

    O tesseract vai gerar um arquivo `.traineddata` na pasta data. Este arquivo poderá ser usado como modelo em futuras detecções de OCR como se fosse um idiomna DESDE QUE ele seja copiado/movido para o diretório TESSDATA_PREFIX em questão. No caso desse tutorial no caminho: `<caminho-até-tesstrain>/tesseract/tessdata/` .

    Exemplo:

    ```
    tesseract <imagem-a-ter-texto-detectado> stdout -l por
    ```

# Referências e agradecimentos
- https://github.com/tesseract-ocr/tesstrain/blob/master/README.md
- https://stackoverflow.com/questions/43352918/how-do-i-train-tesseract-4-with-image-data-instead-of-a-font-file
- toda a comunidade colaborativa na internet