# Comando Gemini CLI: `/git:commit`

Este documento explica o propósito e o funcionamento do comando customizado `/git:commit` do Gemini CLI, definido no arquivo `commit.toml`.

## Visão Geral

O comando `/git:commit` foi projetado para automatizar a criação de mensagens de commit que seguem a especificação **[Conventional Commits](https://www.conventionalcommits.org/)**. Ele analisa as mudanças *staged* (preparadas) dentro de uma pasta específica e gera uma mensagem de commit formatada, concisa e padronizada.

-----

## Propósito

Manter um histórico de commits limpo e padronizado é crucial para a manutenibilidade de um projeto. No entanto, escrever manualmente mensagens de commit que sigam um formato estrito (como o Conventional Commits) pode ser repetitivo e propenso a erros.

Este comando resolve esse problema ao delegar a tarefa de análise e formatação para o Gemini, garantindo que cada commit seja:

  - **Consistente:** Sempre no formato `<type>(<scope>): <description>`.
  - **Informativo:** O tipo e a descrição são gerados com base nas mudanças reais do código.
  - **Rastreável:** O *scope* é usado para vincular o commit a um ticket (ex: JIRA).

-----

## Como Funciona

O comando é definido por um `prompt` que instrui o Gemini a agir como um especialista em Git. Ele utiliza recursos poderosos do Gemini CLI:

1.  **Argumentos Posicionais:**

      * `{{args_0}}`: Captura o primeiro argumento fornecido pelo usuário, que deve ser o **ID do ticket JIRA** (ex: `PROJ-123`).
      * `{{args_1}}`: Captura o segundo argumento, que é o **caminho para a pasta** contendo as mudanças.

2.  **Execução de Shell (`!{...}`):**

      * `!{git diff --staged {{args_1}}}`: Este é o núcleo da automação. O comando executa `git diff --staged` na pasta especificada pelo usuário. A saída (o "diff" do código) é injetada diretamente no prompt.

3.  **Instruções Claras para o Modelo:**

      * O prompt fornece regras estritas para o Gemini seguir, incluindo o formato da mensagem, os tipos de commit válidos (`feat`, `fix`, etc.) e o limite de 72 caracteres, garantindo um resultado previsível e correto.

-----

## Como Usar

Para utilizar o comando, siga estes passos:

1.  **Prepare suas mudanças:** Certifique-se de que todos os arquivos que você deseja incluir no commit estejam *staged*.

    ```bash
    git add src/sua-pasta/
    ```

2.  **Execute o comando no Gemini CLI:** Forneça o ID do JIRA e o caminho da pasta como argumentos.

    ```
    /git:commit PROJ-123 src/sua-pasta/
    ```

### Exemplo de Saída

Após analisar o `diff`, o Gemini retornará apenas a mensagem de commit formatada:

```
feat(PROJ-123): adiciona endpoint de autenticação de usuário
```

Você pode então usar o comando `/copy` do Gemini CLI para copiar essa mensagem e usá-la em seu commit:

```bash
git commit -m "feat(PROJ-123): adiciona endpoint de autenticação de usuário"
```
