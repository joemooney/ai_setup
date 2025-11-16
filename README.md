# AI Agent Setup & Configuration

A comprehensive resource for setting up, configuring, and using AI agents on Ubuntu. This repository contains installation scripts, configuration guides, best practices, and lessons learned from real-world AI agent deployments.

## Quick Start

Run the interactive setup menu:

```bash
./setup.sh
```

Or jump directly to a specific category:

```bash
./setup.sh speech    # Speech & dictation tools
./setup.sh llm       # LLM tools
./setup.sh docs      # Documentation
```

## What's Inside

### Speech & Dictation Tools

- **[OpenAI Whisper](tools/speech/whisper/)** - Local speech recognition
- **[Voice Mode](tools/speech/voice-mode/)** - Voice interface for Claude Code
- **[Dictation Setup](tools/speech/dictation/)** - General dictation configuration

### LLM Tools

- **[Local LLM Deployment](tools/llm/local-deployment/)** - Run Ollama, LocalAI, vLLM locally
- **[Claude Code Integration](tools/llm/claude-code/)** - Integrate with Claude Code

### Documentation

- **[Best Practices](docs/best-practices.md)** - Lessons learned and recommendations
- **[Troubleshooting](docs/troubleshooting.md)** - Common issues and solutions

### Configuration

- **[Examples](config/examples/)** - Working configuration examples
- **[Templates](config/templates/)** - Configuration file templates

## Repository Structure

```
ai_setup/
├── setup.sh                       # Interactive setup menu
├── README.md                      # This file
│
├── tools/
│   ├── speech/                    # Speech and dictation tools
│   │   ├── whisper/              # OpenAI Whisper
│   │   ├── voice-mode/           # Voice Mode for Claude Code
│   │   └── dictation/            # General dictation setup
│   │
│   ├── llm/                      # Large Language Model tools
│   │   ├── local-deployment/     # Local LLM setup (Ollama, LocalAI, vLLM)
│   │   └── claude-code/          # Claude Code integration
│   │
│   └── productivity/             # Additional productivity tools
│
├── docs/                         # Documentation
│   ├── best-practices.md        # Lessons learned
│   └── troubleshooting.md       # Common issues
│
└── config/                       # Configuration files
    ├── examples/                # Working examples
    └── templates/               # Templates
```

## Popular Tools at a Glance

| Tool | Category | Purpose | Quick Install |
|------|----------|---------|---------------|
| Whisper | Speech | Local speech-to-text | [Guide](tools/speech/whisper/README.md) |
| Voice Mode | Speech | Voice interface for Claude | [Guide](tools/speech/voice-mode/README.md) |
| Ollama | LLM | Run models like Llama locally | [Guide](tools/llm/local-deployment/README.md#ollama) |
| LocalAI | LLM | OpenAI-compatible local API | [Guide](tools/llm/local-deployment/README.md#localai) |
| vLLM | LLM | High-performance inference | [Guide](tools/llm/local-deployment/README.md#vllm) |

## Prerequisites

Most tools in this repository require:

- Ubuntu 20.04 or later (some tools work on other Linux distributions)
- Python 3.8+
- Node.js 18+ (for some tools)
- Git

Specific requirements are listed in each tool's documentation.

## Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/ai_setup.git
   cd ai_setup
   ```

2. Run the setup menu:
   ```bash
   ./setup.sh
   ```

3. Follow the interactive prompts to install your desired tools

## Contributing

Contributions are welcome! If you have:

- New tool configurations
- Best practices to share
- Bug fixes or improvements
- Additional platform support

Please open an issue or pull request.

## Documentation for Claude Code

This repository includes special files for Claude Code integration:

- `CLAUDE.md` - Instructions for Claude Code when working in this repository
- `PROMPT_HISTORY.md` - Development session history

## License

See [LICENSE](LICENSE) file for details.

## Support

For issues or questions:

1. Check the [troubleshooting guide](docs/troubleshooting.md)
2. Review tool-specific README files
3. Open an issue on GitHub

## Roadmap

- [ ] Add Windows WSL2 support details
- [ ] Add macOS setup guides
- [ ] Expand productivity tools section
- [ ] Add Docker-based deployment options
- [ ] Create video tutorials
- [ ] Add performance benchmarking guides
