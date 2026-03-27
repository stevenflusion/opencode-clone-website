#!/bin/bash
# Clone Website Skill Installer for OpenCode
# Usage: ./install.sh

set -e

echo "🎯 Installing Clone Website Skill for OpenCode..."

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create the skills directory if it doesn't exist
mkdir -p ~/.opencode/skills/clone-website

# Copy the skill
cp "$SCRIPT_DIR/.opencode/skills/clone-website/SKILL.md" ~/.opencode/skills/clone-website/

echo "✅ Skill installed successfully!"
echo ""
echo "Next steps:"
echo "1. Restart OpenCode"
echo "2. Use the skill by saying: 'Clone this website: https://example.com'"
echo ""
echo "Troubleshooting: If the skill doesn't appear, try:"
echo "   ls ~/.opencode/skills/clone-website/"