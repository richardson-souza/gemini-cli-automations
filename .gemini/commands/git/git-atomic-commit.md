# Script de Automação de Commits Atômicos com Gemini CLI

Este script Bash automatiza o processo de criação de **commits atômicos** (um commit por arquivo) para as suas alterações. Ele utiliza o **Gemini CLI** para gerar mensagens de commit inteligentes e formatadas de acordo com o padrão **Conventional Commits**, vinculando cada commit a um ID do JIRA.

## Pré-requisitos

  - Git instalado.
  - [Gemini CLI](https://www.google.com/search?q=https://github.com/google/gemini-cli) instalado e autenticado na sua máquina.

-----

## Como Usar

1.  **Torne o script executável:**

    ```bash
    chmod +x git-atomic-commit.sh
    ```

2.  **Adicione seus arquivos à área de stage:**

    ```bash
    # Para todos os arquivos modificados
    git add .
    ```

    ou para arquivos específicos:

    ```bash
    # Ou para arquivos específicos
    git add <caminho/do/arquivo1> <caminho/do/arquivo2>
    ```

3.  **Execute o script** passando o ID do seu ticket JIRA como argumento:

    ```bash
    ./git-atomic-commit.sh SEU-ID-JIRA
    ```

    Por exemplo:

    ```bash
    ./git-atomic-commit.sh PTFMD-3606
    ```

-----

## O que o Script Faz ⚙️

O script executa os seguintes passos:

1.  **Verifica o ID do JIRA:** Garante que um ID foi fornecido como argumento.
2.  **Lista os Arquivos:** Identifica todos os arquivos que você adicionou à área de stage (`git add`).
3.  **Reseta o Stage:** Remove temporariamente todos os arquivos do stage para processá-los individualmente.
4.  **Inicia o Loop:** Para cada arquivo que estava originalmente no stage, ele:
    a. Adiciona **apenas o arquivo atual** de volta ao stage.
    b. Pega o `diff` (as alterações) desse arquivo.
    c. Monta um **prompt detalhado** para o Gemini AI, injetando o `diff`, o ID do JIRA e o caminho do arquivo.
    d. Envia o prompt para o `gemini` e captura a mensagem de commit gerada (pegando apenas a última linha da saída para evitar mensagens de status).
    e. Executa o `git commit` para o arquivo atual com a mensagem gerada.
5.  **Finaliza:** Exibe uma mensagem de sucesso ao final do processo.

-----

## Customização 🎨

Você pode alterar o comportamento da IA modificando a variável `PROMPT_TEMPLATE` dentro do script. Isso permite ajustar as regras, o formato ou o tom das mensagens de commit geradas para se adequarem melhor às convenções do seu time.
