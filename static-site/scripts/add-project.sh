#!/usr/bin/env bash

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Tokyo Rust Projects - Add Your Project ===${NC}\n"

# Check if gum is installed
if ! command -v gum &> /dev/null; then
    echo "Error: 'gum' is not installed. Please run 'mise install' or install it first."
    exit 1
fi

# Get project title
PROJECT_NAME=$(gum input --placeholder "Project name (e.g., 'My Awesome Rust Tool')")
if [ -z "$PROJECT_NAME" ]; then
    echo "Error: Project name is required"
    exit 1
fi

# Get repository URL
REPO_URL=$(gum input --placeholder "Repository URL (e.g., 'https://github.com/username/project')")
if [ -z "$REPO_URL" ]; then
    echo "Error: Repository URL is required"
    exit 1
fi

# Get GitHub username (optional)
echo -e "\n${BLUE}GitHub username (optional - leave empty for none)${NC}"
GITHUB_USERNAME=$(gum input --placeholder "GitHub username (or press Enter to skip)")

# Get logo URL with options
echo -e "\n${BLUE}Select logo option:${NC}"
LOGO_OPTIONS=("Custom URL" "None")
if [ -n "$GITHUB_USERNAME" ]; then
    LOGO_OPTIONS=("Use GitHub avatar" "${LOGO_OPTIONS[@]}")
fi

LOGO_CHOICE=$(gum choose "${LOGO_OPTIONS[@]}")

LOGO_URL=""
case "$LOGO_CHOICE" in
    "Use GitHub avatar")
        LOGO_URL="https://github.com/${GITHUB_USERNAME}.png?size=200"
        echo -e "${GREEN}✓ Using GitHub avatar: ${LOGO_URL}${NC}"
        ;;
    "Custom URL")
        LOGO_URL=$(gum input --placeholder "Enter logo URL")
        if [ -n "$LOGO_URL" ]; then
            echo -e "${GREEN}✓ Using custom logo: ${LOGO_URL}${NC}"
        fi
        ;;
    "None")
        LOGO_URL=""
        echo -e "${GREEN}✓ No logo will be used${NC}"
        ;;
esac

# Get English description
echo -e "\n${BLUE}Enter project description (English):${NC}"
DESCRIPTION_EN=$(gum write --placeholder "Describe your project...")
if [ -z "$DESCRIPTION_EN" ]; then
    echo "Error: English description is required"
    exit 1
fi

# Get Japanese description (optional)
echo -e "\n${BLUE}Enter project description (Japanese) - Press Ctrl+D on empty line to skip${NC}"
DESCRIPTION_JP=$(gum write --placeholder "プロジェクトの説明を入力してください... (or leave empty to use English)" || echo "")

if [ -z "$DESCRIPTION_JP" ]; then
    DESCRIPTION_JP="$DESCRIPTION_EN"
    echo -e "${GREEN}✓ Using English description for Japanese page${NC}"
fi

# Prepare the TOML entry
TOML_ENTRY_EN="
[[extra.project]]
name = \"${PROJECT_NAME}\"
url = \"${REPO_URL}\""

TOML_ENTRY_JP="$TOML_ENTRY_EN"

if [ -n "$LOGO_URL" ]; then
    TOML_ENTRY_EN="${TOML_ENTRY_EN}
logo_url = \"${LOGO_URL}\""
    TOML_ENTRY_JP="${TOML_ENTRY_JP}
logo_url = \"${LOGO_URL}\""
fi

TOML_ENTRY_EN="${TOML_ENTRY_EN}
description = \"${DESCRIPTION_EN}\""

TOML_ENTRY_JP="${TOML_ENTRY_JP}
description = \"${DESCRIPTION_JP}\""

# Function to add project to a file
add_project_to_file() {
    local file=$1
    local toml_entry=$2

    # Find the line number where the front matter ends (first +++ after the start)
    local end_line=$(grep -n "^+++" "$file" | tail -1 | cut -d: -f1)

    if [ -z "$end_line" ]; then
        echo "Error: Could not find end of front matter in $file"
        return 1
    fi

    # Insert the new project entry before the closing +++
    # Create a temporary file
    local temp_file=$(mktemp)

    # Copy everything up to (but not including) the closing +++
    head -n $((end_line - 1)) "$file" > "$temp_file"

    # Add the new project entry
    echo "$toml_entry" >> "$temp_file"

    # Add the closing +++ and everything after
    tail -n +${end_line} "$file" >> "$temp_file"

    # Replace the original file
    mv "$temp_file" "$file"
}

# Add to English file
PROJECTS_EN="content/projects.md"
if [ ! -f "$PROJECTS_EN" ]; then
    echo "Error: $PROJECTS_EN not found"
    exit 1
fi

echo -e "\n${BLUE}Adding project to ${PROJECTS_EN}...${NC}"
add_project_to_file "$PROJECTS_EN" "$TOML_ENTRY_EN"
echo -e "${GREEN}✓ Added to English projects page${NC}"

# Add to Japanese file
PROJECTS_JP="content/projects.jp.md"
if [ ! -f "$PROJECTS_JP" ]; then
    echo "Error: $PROJECTS_JP not found"
    exit 1
fi

echo -e "${BLUE}Adding project to ${PROJECTS_JP}...${NC}"
add_project_to_file "$PROJECTS_JP" "$TOML_ENTRY_JP"
echo -e "${GREEN}✓ Added to Japanese projects page${NC}"

echo -e "\n${GREEN}=== Success! ===${NC}"
echo -e "Your project has been added to both projects pages."
echo -e "\nNext steps:"
echo -e "1. Review the changes: ${BLUE}git diff${NC}"
echo -e "2. Commit the changes: ${BLUE}git add content/projects*.md && git commit -m 'Add ${PROJECT_NAME} to projects'${NC}"
echo -e "3. Push and create a pull request: ${BLUE}git push${NC}"
echo -e "\nThank you for contributing to Tokyo Rust! 🦀"
