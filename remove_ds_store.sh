#!/bin/bash
# This script deletes all .DS_Store files in the repo,
# removes them from Git tracking, and adds .DS_Store to .gitignore

echo "Finding and deleting .DS_Store files in the working directory..."
find . -name ".DS_Store" -print -delete

echo "Removing .DS_Store files from Git tracking..."
# List all .DS_Store files currently tracked and remove them from the index
git ls-files | grep -i "\.DS_Store" | while read -r file; do
    git rm --cached "$file"
done

echo "Ensuring .DS_Store is added to .gitignore..."
if [ ! -f .gitignore ]; then
  touch .gitignore
fi

if ! grep -q "\.DS_Store" .gitignore; then
    echo ".DS_Store" >> .gitignore
    git add .gitignore
    echo ".DS_Store added to .gitignore."
else
    echo ".DS_Store is already in .gitignore."
fi

echo "Committing the changes..."
git commit -m "Remove .DS_Store files and update .gitignore"

echo "Script complete. Please push your changes using 'git push'."
