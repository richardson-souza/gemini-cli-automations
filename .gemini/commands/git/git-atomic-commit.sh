#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
# The JIRA ID is the first argument.
JIRA_ID=$1

# The prompt template for the commit message.
PROMPT_TEMPLATE="You are an expert at writing Git commit messages following the Conventional Commits specification. Your task is to generate a commit message for the staged changes in the file '__FILE_PATH__'. Analyze the following git diff:
\`\`\`diff
__GIT_DIFF__
\`\`\`
Create a single-line commit message adhering to these strict rules:
1. Format: <type>(<scope>): <description>
2. <type>: Choose one: feat, fix, docs, style, refactor, test, chore, build.
3. <scope>: Use the JIRA ID '__JIRA_ID__'.
4. <description>: Write a concise, imperative-mood description of the change.
5. Length: The entire line MUST NOT exceed 72 characters.
Your final output must be ONLY the single-line commit message."
# --- End Configuration ---

# Check if a JIRA ID was provided.
if [ -z "$JIRA_ID" ]; then
  echo "Error: Please provide a JIRA ID as the first argument."
  echo "Usage: ./git-atomic-commit.sh <JIRA-ID>"
  exit 1
fi

# Get the list of currently staged files.
STAGED_FILES=$(git diff --name-only --cached)

if [ -z "$STAGED_FILES" ]; then
  echo "No files staged to commit. Please run 'git add'."
  exit 0
fi

echo "Found staged files:"
echo "$STAGED_FILES"
echo "---"

# Temporarily unstage all files to process them one-by-one.
git reset HEAD -- . > /dev/null

# Loop through each file that was originally staged.
for FILE in $STAGED_FILES; do
  echo "Processing: $FILE"

  # Stage just the current file.
  git add "$FILE"

  # Get the git diff for the staged file.
  GIT_DIFF=$(git diff --staged "$FILE")

  # Build the final prompt by replacing placeholders.
  FINAL_PROMPT="${PROMPT_TEMPLATE/__JIRA_ID__/$JIRA_ID}"
  FINAL_PROMPT="${FINAL_PROMPT/__FILE_PATH__/$FILE}"
  FINAL_PROMPT="${FINAL_PROMPT/__GIT_DIFF__/$GIT_DIFF}"

  # Generate the commit message and take only the last line of the output.
  echo "  -> Generating commit message with Gemini..."
  COMMIT_MSG=$(gemini -p "$FINAL_PROMPT" | tail -n 1)

  # Create the commit.
  echo "  -> Committing with message: $COMMIT_MSG"
  git commit -m "$COMMIT_MSG"
  echo "---"
done

echo "✅ Atomic commit process complete."
