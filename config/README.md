# Configuration Files

This directory contains example configurations and templates for various AI tools.

## Examples

Working configuration examples that you can use as-is or adapt to your needs:

- **[ollama-with-claude.sh](examples/ollama-with-claude.sh)** - Configure Claude Code to use Ollama
- **[voice-mode-mcp.json](examples/voice-mode-mcp.json)** - Voice Mode MCP server configuration

## Templates

Configuration templates that you can customize:

- **[bashrc-ai-setup.sh](templates/bashrc-ai-setup.sh)** - Environment variables for ~/.bashrc or ~/.zshrc

## Usage

### Using Examples

1. Copy example to your system:
   ```bash
   cp config/examples/ollama-with-claude.sh ~/setup-ollama.sh
   chmod +x ~/setup-ollama.sh
   ```

2. Run the example:
   ```bash
   source ~/setup-ollama.sh
   ```

### Using Templates

1. Copy template and customize:
   ```bash
   cp config/templates/bashrc-ai-setup.sh ~/.ai-setup-env
   ```

2. Edit the file to match your setup:
   ```bash
   nano ~/.ai-setup-env
   ```

3. Source in your shell config:
   ```bash
   # Add to ~/.bashrc or ~/.zshrc
   source ~/.ai-setup-env
   ```

## Directory Structure

```
config/
├── README.md           # This file
├── examples/           # Working configurations
│   ├── ollama-with-claude.sh
│   └── voice-mode-mcp.json
└── templates/          # Customizable templates
    └── bashrc-ai-setup.sh
```

## Contributing

Have a useful configuration to share? Please:

1. Add it to the appropriate directory
2. Document what it does
3. Test that it works
4. Submit a pull request

## Common Configurations

### Local LLM Setup

For Ollama:
```bash
export ANTHROPIC_BASE_URL=http://localhost:11434/v1
export ANTHROPIC_AUTH_TOKEN=ollama-local
```

For LocalAI:
```bash
export ANTHROPIC_BASE_URL=http://localhost:8080/v1
export ANTHROPIC_AUTH_TOKEN=your-api-key
```

### Voice Mode MCP

User-level config at `~/.claude/mcp.json`:
```json
{
  "mcpServers": {
    "voice-mode": {
      "command": "uvx",
      "args": ["voice-mode"]
    }
  }
}
```

Project-level config at `.claude/mcp.json`:
```json
{
  "mcpServers": {
    "voice-mode": {
      "command": "uvx",
      "args": ["voice-mode"],
      "env": {
        "WHISPER_MODEL": "small"
      }
    }
  }
}
```

## See Also

- [Best Practices](../docs/best-practices.md)
- [Troubleshooting](../docs/troubleshooting.md)
- Tool-specific READMEs in [tools/](../tools/)
