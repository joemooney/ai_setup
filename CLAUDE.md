# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a documentation repository for AI-related Ubuntu installation and setup instructions. Currently contains setup guides for:
- OpenAI Whisper speech recognition
- Voice Mode universal installer for various platforms
- Local and in-house LLM integration with Claude Code

## Common Commands

### Whisper Setup
```bash
# Activate the Whisper virtual environment
source whisper-env/bin/activate

# Install/Update Whisper and dependencies
pip install -U openai-whisper pyaudio gradio
```

### Voice Mode Installation
```bash
# Run the Voice Mode installer
bash install.sh

# Or download and run directly
curl -sSf https://getvoicemode.com/install.sh | sh
```

## Architecture and Structure

This repository is primarily documentation-focused with setup scripts:

- `whisper.md` - OpenAI Whisper installation instructions for Ubuntu
- `install.sh` - Universal installer script for Voice Mode supporting macOS, Ubuntu, and Fedora (including WSL2)
- `Local_LLM.md` - Comprehensive guide for using local and in-house LLMs with Claude Code
- `.gitignore` - Currently configured for Node.js but should be updated for Python projects

## Development Notes

### Adding New AI Tool Setup Guides
- Create new markdown files following the pattern of `whisper.md`
- Include system dependencies, installation commands, and activation instructions
- Test commands on target platforms before documenting

### Working with install.sh
The Voice Mode installer is a comprehensive bash script that:
- Detects OS (macOS, Ubuntu, Fedora) and architecture
- Handles WSL2-specific audio configuration
- Installs system dependencies via package managers (Homebrew, APT, DNF)
- Sets up Python environment with UV/UVX
- Configures Claude Code MCP integration

### Git Workflow
Per user instructions in ~/.claude/CLAUDE.md:
- Commit and push to GitHub after each set of changes
- Keep PROMPT_HISTORY.md updated with all development sessions
- Update REQUIREMENTS.md with project requirements