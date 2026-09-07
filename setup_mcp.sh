#!/bin/bash

# Setup Swiftzilla MCP Server für Antigravity CLI

CONFIG_DIR="$HOME/.gemini/antigravity-cli"
CONFIG_FILE="$CONFIG_DIR/config.json"

# Verzeichnis erstellen falls nötig
mkdir -p "$CONFIG_DIR"

# Config schreiben
cat > "$CONFIG_FILE" << 'EOF'
{
    "mcpServers": {
        "swiftzilla": {
            "command": "npx",
            "args": [
                "-y",
                "@swiftzilla/mcp",
                "--api-key",
                "sk_live_ISBEl6gBdDenomEszYJeUheBZeEIL0K8jWakG_qAM0U"
            ]
        }
    }
}
EOF

echo "✅ Swiftzilla MCP Server wurde konfiguriert!"
echo "📄 Config: $CONFIG_FILE"
echo ""
echo "⚠️  Bitte Antigravity CLI neu starten, damit der Server geladen wird."
