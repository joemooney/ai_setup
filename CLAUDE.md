# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive resource repository for AI agent setup, configuration, and usage on Ubuntu. It contains:
- Installation scripts and guides for speech recognition, LLMs, and productivity tools
- Best practices and lessons learned
- Troubleshooting guides
- Configuration examples and templates

The repository is organized hierarchically with tools categorized by function.

## Repository Structure

```
ai_setup/
├── setup.sh                       # Interactive setup menu (main entry point)
├── README.md                      # Repository overview and quick start
│
├── tools/                        # All AI tools organized by category
│   ├── speech/                   # Speech and dictation tools
│   │   ├── whisper/             # OpenAI Whisper setup
│   │   ├── voice-mode/          # Voice Mode for Claude Code
│   │   └── dictation/           # General dictation guides
│   │
│   ├── llm/                     # LLM tools and integrations
│   │   ├── local-deployment/    # Local LLM setup (Ollama, LocalAI, vLLM)
│   │   └── claude-code/         # Claude Code integration
│   │
│   └── productivity/            # Additional productivity tools
│
├── docs/                        # Documentation
│   ├── best-practices.md       # Lessons learned and recommendations
│   └── troubleshooting.md      # Common issues and solutions
│
└── config/                      # Configuration files
    ├── examples/               # Working examples
    └── templates/              # Customizable templates
```

## Common Commands

### Interactive Setup Menu
```bash
# Run the main setup script
./setup.sh

# Or jump to specific section
./setup.sh speech    # Speech tools
./setup.sh llm       # LLM tools
./setup.sh docs      # Documentation
```

### Whisper Setup
```bash
# Location: tools/speech/whisper/
# See tools/speech/whisper/README.md for installation

# Activate Whisper environment
source whisper-env/bin/activate

# Install/Update Whisper
pip install -U openai-whisper pyaudio gradio
```

### Voice Mode Installation
```bash
# Location: tools/speech/voice-mode/
cd tools/speech/voice-mode
./install.sh

# Or use the installer from the web
curl -sSf https://getvoicemode.com/install.sh | sh
```

### Local LLM Setup
```bash
# Location: tools/llm/local-deployment/
# See tools/llm/local-deployment/README.md for detailed guides

# Example: Ollama setup
curl -fsSL https://ollama.com/install.sh | sh
ollama run llama2

# Configure Claude Code to use Ollama
source config/examples/ollama-with-claude.sh
```

## Key Files and Locations

### Documentation
- `README.md` - Main entry point, quick start guide
- `docs/best-practices.md` - Lessons learned, recommendations, optimization tips
- `docs/troubleshooting.md` - Common issues across all tools

### Speech Tools
- `tools/speech/whisper/README.md` - Whisper installation and usage
- `tools/speech/voice-mode/README.md` - Voice Mode setup and configuration
- `tools/speech/voice-mode/install.sh` - Voice Mode installer script
- `tools/speech/dictation/README.md` - General dictation setup guide

### LLM Tools
- `tools/llm/local-deployment/README.md` - Comprehensive local LLM guide (Ollama, LocalAI, vLLM)
- `tools/llm/claude-code/` - Claude Code integration specifics

### Configuration
- `config/examples/` - Working configuration examples
- `config/templates/` - Customizable templates
- `config/README.md` - Guide to using configs

### Project Management
- `CLAUDE.md` - This file (Claude Code instructions)
- `PROMPT_HISTORY.md` - Development session history
- `.gitignore` - Git ignore rules

## Development Notes

### Adding New Tools

When adding a new AI tool to the repository:

1. Determine the appropriate category (speech, llm, productivity)
2. Create a subdirectory under `tools/{category}/{tool-name}/`
3. Create a comprehensive README.md with:
   - Overview and features
   - Installation instructions
   - Usage examples
   - Troubleshooting section
4. Add installation script if applicable
5. Update the parent category README
6. Update `setup.sh` to include the new tool
7. Add configuration examples to `config/examples/`
8. Document any lessons learned in `docs/best-practices.md`

### Directory Naming Conventions

- Use lowercase with hyphens: `voice-mode`, `local-deployment`
- Tool-specific directories: `tools/{category}/{tool-name}/`
- Each tool directory should contain:
  - `README.md` - Main documentation
  - `install.sh` or `setup.sh` - Installation script (if applicable)
  - `examples/` - Usage examples (optional)

### Documentation Standards

- Use GitHub-flavored Markdown
- Include working code examples
- Provide both Ubuntu and WSL2 instructions where applicable
- Test all commands before documenting
- Include troubleshooting sections
- Reference related documentation with relative links

### Git Workflow

Per user instructions in ~/.claude/CLAUDE.md:

1. **Commit frequently** - Commit and push after each set of changes
2. **Update PROMPT_HISTORY.md** - Document all development sessions
3. **Keep documentation current** - Update relevant READMEs when making changes
4. **Test changes** - Verify scripts and commands work before committing

### Interactive Setup Script (setup.sh)

The main `setup.sh` script provides:
- Color-coded terminal UI
- Nested menu navigation
- Direct access to tool documentation
- Installation script execution
- Can be run interactively or with command-line args

When adding tools, update the appropriate menu function in `setup.sh`.

## Architecture Patterns

### Tool Organization
- **Two-level minimum** - Tools are nested at least 2 levels (e.g., `tools/speech/whisper/`)
- **Category grouping** - Related tools grouped by category
- **Self-contained** - Each tool directory is self-contained with its own README

### Documentation Hierarchy
- **Top-level README** - High-level overview, quick start
- **Category READMEs** - Overview of tools in category
- **Tool READMEs** - Detailed tool-specific documentation
- **Shared docs** - Cross-cutting concerns in `docs/`

### Configuration Management
- **Examples** - Working configurations ready to use
- **Templates** - Starting points for customization
- **Documentation** - config/README.md explains usage

## Special Considerations

### WSL2 Support
Many tools have WSL2-specific instructions. When documenting:
- Include WSL2 prerequisites (WSL version, audio setup)
- Note Windows-specific steps (microphone permissions)
- Reference WSL2 sections in troubleshooting guide

### Security
- Keep credentials out of version control
- Document authentication best practices
- Provide secure configuration examples
- Note security considerations in best-practices.md

### Cross-Platform
While focused on Ubuntu:
- Note compatibility with other Linux distributions
- Include macOS notes where applicable
- Document platform-specific differences

## Resources

### Internal Documentation
- [Best Practices](docs/best-practices.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Configuration Guide](config/README.md)

### Tool Documentation
- Tools are documented in their respective README files
- See `tools/` directory structure above

### External References
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Ollama Documentation](https://ollama.ai/docs)
- [OpenAI Whisper](https://github.com/openai/whisper)
- [Voice Mode](https://github.com/mbailey/voicemode)
