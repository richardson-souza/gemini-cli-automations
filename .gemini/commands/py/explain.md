# AutoDoc PY - Gerador Automático de Documentação Python 🐍

Este repositório contém um script Bash projetado para automatizar a criação de documentação técnica para arquivos de código Python. Utilizando o poder do **Google Gemini CLI**, o script analisa um arquivo `.py`, entende cada uma de suas funções e gera um arquivo de documentação detalhado em formato Markdown.

## 📝 O Problema que Resolvemos

Manter a documentação de um projeto atualizada é um desafio constante. É uma tarefa manual, demorada e muitas vezes negligenciada, o que leva a uma base de código difícil de entender e manter. Este script foi criado para eliminar esse trabalho repetitivo, permitindo que os desenvolvedores gerem documentação de alta qualidade com um único comando.

## ✨ Como Funciona

O script `autodoc.sh` atua como um invólucro (wrapper) para um comando customizado do Gemini CLI chamado `/py:explain`. O fluxo de trabalho é o seguinte:

1.  O script recebe o caminho de um arquivo Python como argumento.
2.  Ele invoca o `gemini-cli` com o comando `/py:explain`, passando o conteúdo do arquivo para análise.
3.  O Gemini processa o código e gera uma explicação detalhada para cada função, seguindo uma estrutura pré-definida.
4.  O script captura essa saída e a salva em um novo arquivo chamado `analysis.md`, localizado no mesmo diretório do arquivo Python original.

## 🚀 Pré-requisitos

Antes de usar o script, garanta que você tenha o seguinte instalado e configurado:

  * **Bash:** Presente na maioria dos sistemas Linux e macOS.
  * **Gemini CLI:** A [interface de linha de comando do Google Gemini](https://www.google.com/search?q=https://github.com/google/gemini-cli).
  * **Comando Customizado:** O comando `/py:explain` deve estar configurado no seu ambiente do Gemini CLI, conforme o arquivo `.toml` fornecido.

## 🛠️ Como Usar

1.  **Torne o script executável:**

    ```bash
    chmod +x autodoc.sh
    ```

2.  **Execute o script, passando o caminho do arquivo Python como argumento:**

    ```bash
    ./autodoc.sh /caminho/para/seu/projeto/meu_arquivo.py
    ```

### O Que Ele Faz

Após a execução, um novo arquivo chamado `analysis.md` será criado no mesmo diretório do `meu_arquivo.py`. Este arquivo conterá a documentação de todas as funções encontradas no arquivo de entrada, seguindo a estrutura abaixo:

````markdown
### `nome_da_funcao()`

* **Propósito:** Uma frase clara explicando o que a função faz.
* **Parâmetros:**
    * `nome_do_parametro` (*tipo*): Descrição do parâmetro.
* **Retorna:**
    * (*tipo*): Descrição do que a função retorna.
* **Exemplo de Uso:**
    ```python
    # Um trecho de código simples mostrando como usar a função.
    ```
* **Notas:** Detalhes importantes, possíveis casos extremos ou dependências.
````

-----

## Exemplo Prático

**Arquivo de Entrada (`processador.py`):**

```python
def somar_valores(a: int, b: int) -> int:
    """Uma função simples que retorna a soma de dois números."""
    if not isinstance(a, int) or not isinstance(b, int):
        raise TypeError("Ambos os valores devem ser inteiros.")
    return a + b
```

**Comando Executado:**

```bash
./autodoc.sh processador.py
```

**Arquivo de Saída (`analysis.md`):**

````markdown
### `somar_valores()`

* **Propósito:** Uma função simples que retorna a soma de dois números inteiros.
* **Parâmetros:**
    * `a` (*int*): O primeiro número a ser somado.
    * `b` (*int*): O segundo número a ser somado.
* **Retorna:**
    * (*int*): A soma dos valores de `a` e `b`.
* **Exemplo de Uso:**
    ```python
    # Exemplo de como chamar a função
    resultado = somar_valores(10, 5)
    print(resultado)  # Saída: 15
    ```
* **Notas:** A função levanta um `TypeError` se qualquer um dos inputs não for um número inteiro.
````
