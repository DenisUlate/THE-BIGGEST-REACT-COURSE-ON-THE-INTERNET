#!/bin/bash

# Script to generate folder structure documentation
# Usage: ./generate_folder_list.sh

REPO_ROOT="$(dirname "$(readlink -f "$0")")"
OUTPUT_FILE="$REPO_ROOT/FOLDER_STRUCTURE.md"
TREE_OUTPUT_FILE="$REPO_ROOT/FOLDER_STRUCTURE_TREE.md"

echo "Generating folder structure documentation..."

# Count total folders (excluding .git)
TOTAL_FOLDERS=$(find "$REPO_ROOT" -type d -not -path "*/.git*" | wc -l)
TOTAL_FOLDERS=$((TOTAL_FOLDERS - 1))  # Subtract 1 for root directory

# Generate main folder list
cat > "$OUTPUT_FILE" << EOF
# Complete Folder Structure

This document contains a comprehensive list of all folders and sub-folders in "THE BIGGEST REACT COURSE ON THE INTERNET" repository.

**Total Folders: $TOTAL_FOLDERS**

## Repository Structure

The repository is organized into 22 main sections, each focusing on different aspects of React development:

### Main Sections:
- 01. Fundamentals
- 02. React Hooks
- 03. Beginners Projects
- 04. React w TypeScript
- 05. React with TypeScript Projects
- 06. UI Libraries
- 07. React Hook Form
- 08. Advance Hooks & React 19
- 09. Framer Motion With 10 Projects
- 10. Zustand With 10 Projects
- 11. Redux Toolkit
- 12. React Design Patterns
- 13. TanStack Query
- 14. Unit Testing
- 15. React Testing
- 16. Storybook
- 17. Small Packages
- 18. Build Your Own Component Library
- 19. Monorepos
- 20. React Design System
- 21. React Auth
- 22. React Native

## Complete Directory Listing

\`\`\`text
EOF

# Generate folder list
find "$REPO_ROOT" -type d -not -path "*/.git*" | sed "s|$REPO_ROOT||" | sort | grep -v '^$' >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'EOF'
```

## Usage

This folder structure document provides a complete overview of the repository organization. Each main section contains:

- **Exercise folders**: Practice problems and challenges
- **Solution folders**: Complete solutions to exercises
- **Live coding folders**: Code from live coding sessions
- **Component folders**: Reusable React components
- **Project folders**: Complete project implementations
- **Source folders**: Main source code files

## Navigation Tips

- Use Ctrl+F (or Cmd+F) to search for specific topics or folder names
- The numbering system (01-22) indicates the recommended learning order
- Each major section builds upon concepts from previous sections

---

*Generated automatically from repository structure*
EOF

# Generate tree view if tree command is available
if command -v tree >/dev/null 2>&1; then
    cat > "$TREE_OUTPUT_FILE" << EOF
# Folder Structure - Tree View

This document provides a hierarchical tree view of all folders in "THE BIGGEST REACT COURSE ON THE INTERNET" repository.

**Total Folders: $TOTAL_FOLDERS**

## Tree Structure

\`\`\`text
EOF
    
    tree "$REPO_ROOT" -I '.git' -d --charset=ascii >> "$TREE_OUTPUT_FILE"
    echo '```' >> "$TREE_OUTPUT_FILE"
fi

echo "Documentation generated:"
echo "- $OUTPUT_FILE"
if command -v tree >/dev/null 2>&1; then
    echo "- $TREE_OUTPUT_FILE"
fi