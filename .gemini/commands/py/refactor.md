# Automação de Refatoração de Código com Gemini CLI

Este documento descreve uma automação para o **Gemini CLI** que funciona como um Engenheiro de Dados Principal para analisar, criticar e refatorar funções Python.

## 🎯 Objetivo

O objetivo desta automação é fornecer uma análise de código de alta qualidade e sugestões de refatoração para uma função Python específica. Ao invés de gastar tempo revisando manualmente, você pode usar uma simples instrução em linguagem natural para obter um plano de melhoria completo, incluindo o código refatorado.

-----

## ⚙️ Como Funciona

O comando `/py:refactor` segue um processo bem definido:

1.  **Recebe a Solicitação:** Você fornece um pedido em linguagem natural, especificando a função e o arquivo que deseja analisar.
2.  **Leitura do Arquivo:** A automação usa a ferramenta `read_file` do Gemini para carregar o conteúdo do arquivo Python especificado.
3.  **Análise de Código:** O Gemini, atuando como um Engenheiro de Dados Principal, analisa a função em questão, focando em seu propósito, entradas e saídas.
4.  **Crítica e Recomendações:** Ele avalia o código com base nas melhores práticas de engenharia de software, criticando nomes de variáveis, legibilidade, documentação e tipagem, e sugere melhorias concretas.
5.  **Geração do Código Refatorado:** Por fim, ele gera uma versão final e aprimorada da função, aplicando todas as recomendações, incluindo `type hints` e uma `docstring` completa no padrão Google.

-----

## 🚀 Como Usar

### 1\. Pré-requisitos

  * Ter o [Gemini CLI](https://www.google.com/search?q=https://cloud.google.com/vertex-ai/docs/generative-ai/gemini/gemini-cli) instalado e configurado.

### 2\. Instalação do Comando

Para disponibilizar o comando `/py:refactor`, você precisa criar o arquivo `.toml` no diretório de comandos do Gemini.

```bash
# Crie a estrutura de diretórios se ela não existir
mkdir -p ~/.gemini/commands/py

# Crie o arquivo de configuração do comando
touch ~/.gemini/commands/py/refactor.toml
```

Agora, copie o conteúdo abaixo para dentro do arquivo `~/.gemini/commands/py/refactor.toml`:

```toml
description = "Refatora uma função Python específica usando um pedido em linguagem natural."
prompt = """
**Master Instruction:** O usuário fornecerá um pedido em linguagem natural que inclui um nome de função e um caminho de arquivo. Seu primeiro passo é analisar este pedido para identificar o caminho do arquivo. Em seguida, você **DEVE usar a ferramenta `read_file`** para obter o conteúdo desse arquivo. Depois de ter o conteúdo do arquivo, prossiga com a análise detalhada abaixo, focando na função especificada.

**User's Request:** `{{args}}`

---

**Role:** Você deve atuar como um Engenheiro de Dados Principal, um especialista experiente em Python, PySpark e SQL. Você é um forte defensor das melhores práticas de engenharia de software, enfatizando código limpo, eficiente e excepcionalmente bem documentado.

**Task:** Sua missão é analisar minuciosamente a função solicitada a partir do conteúdo do arquivo que você leu e fornecer um plano abrangente para melhoria.

**Instructions:**
Para a função especificada, você deve estruturar sua resposta usando o seguinte formato precisamente:

**1. Análise do Código**
* **Propósito:** Um resumo conciso, em uma frase, do objetivo principal da função.
* **Entradas:** Uma descrição dos parâmetros que a função aceita.
* **Saídas:** Uma descrição do que a função retorna ou dos efeitos colaterais que ela produz.

**2. Crítica e Recomendações**
* **Nomenclatura de Função e Variáveis:** Critique os nomes atuais e sugira alternativas mais descritivas e intuitivas que sigam as melhores práticas (ex: PEP 8 para Python).
* **Legibilidade e Lógica:** Identifique qualquer lógica complexa, pouco clara ou ineficiente. Sugira simplificações, abordagens alternativas ou otimizações de desempenho, quando aplicável.
* **Documentação:** Aponte a falta ou inadequação da documentação existente.
* **Tipagem (Type Hinting para Python):** Recomende a adição de `type hints` para melhorar a clareza do código e permitir a análise estática.

**3. Código Refatorado**
Forneça a versão completa e aprimorada da função. Esta versão final deve incluir:
* Os nomes de função e variáveis aprimorados.
* Quaisquer simplificações lógicas que você recomendou.
* Tipagem completa (se aplicável).
* Uma **docstring** abrangente que explique claramente o propósito da função, os argumentos (`Args:`), o valor de retorno (`Returns:`) e quaisquer exceções levantadas (`Raises:`).
"""
```

### 3\. Execução

Agora você pode usar o comando diretamente no Gemini CLI.

**Exemplo:**

Suponha que você tenha um arquivo chamado `processamento.py` com o seguinte conteúdo:

```python
# processamento.py
def proc_dados(lista):
    s = 0
    for i in lista:
        if i > 0:
            s += (i*i)
    return s
```

Dentro do Gemini CLI, execute o seguinte comando:

```
/py:refactor analise e refatore a função 'proc_dados' no arquivo 'processamento.py'
```

-----

## 🤖 Usando em um Script Bash

Você também pode chamar essa automação a partir de um script Bash para, por exemplo, salvar a análise em um arquivo `.md`.

1.  **Crie o script `refatorar.sh`:**

    ```bash
    touch refatorar.sh
    chmod +x refatorar.sh
    ```

2.  **Adicione o conteúdo ao script:**

    ```bash
    #!/bin/bash

    # Verifica se os argumentos foram fornecidos
    if [ "$#" -ne 2 ]; then
        echo "Uso: $0 <nome_da_funcao> <caminho_do_arquivo>"
        exit 1
    fi

    FUNCTION_NAME=$1
    FILE_PATH=$2
    OUTPUT_FILE="analise_${FUNCTION_NAME}.md"

    echo "Gerando análise para a função '${FUNCTION_NAME}' em '${FILE_PATH}'..."

    # Monta a solicitação para o Gemini
    REQUEST="analise e refatore a função '${FUNCTION_NAME}' no arquivo '${FILE_PATH}'"

    # Chama o Gemini CLI em modo não interativo e salva a saída
    gemini -p "/py:refactor ${REQUEST}" | tail -n +2 > "$OUTPUT_FILE"

    echo "Análise salva em: ${OUTPUT_FILE}"
    ```

    *_Nota: `| tail -n +2` é usado para remover avisos como "Data collection is disabled." que podem aparecer na saída._*

3.  **Execute o script:**

    ```bash
    ./refatorar.sh proc_dados processamento.py
    ```

Isso irá gerar um arquivo `analise_proc_dados.md` com a resposta completa do Gemini, pronto para ser revisado.
