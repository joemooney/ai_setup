# Voice Mode for Claude Code

Voice Mode provides a voice interface for Claude Code, enabling real-time voice conversations with Claude using local speech recognition and text-to-speech.

## Overview

Voice Mode uses:
- **Whisper** (local) for speech-to-text
- **Kokoro** (local) for text-to-speech
- All processing happens locally on your machine

## Installation

Run the installation script:

```bash
./install.sh
```

The installer will:
1. Detect your OS and architecture
2. Install system dependencies (Node.js, portaudio, ffmpeg, etc.)
3. Install UV/UVX for Python package management
4. Configure Claude Code to use Voice Mode
5. Set up the MCP server integration

### Supported Platforms

- **macOS** (Apple Silicon and Intel)
- **Ubuntu** 20.04+ (including WSL2)
- **Fedora** 36+

### Prerequisites

The installer will check for and install:
- Python 3.8+
- Node.js 18+
- System audio libraries
- Claude Code CLI

## Usage

### Start a Voice Conversation

```bash
claude converse
```

This opens an interactive voice session where you can:
- Speak to Claude (using local Whisper for transcription)
- Hear Claude's responses (using local Kokoro TTS)
- Continue the conversation naturally

### Check Service Status

```bash
# Check if Whisper and Kokoro services are running
claude voice_status

# Check specific services
claude service whisper status
claude service kokoro status
```

### Manage Services

```bash
# Start services
claude service whisper start
claude service kokoro start

# Stop services
claude service whisper stop
claude service kokoro stop

# Restart services
claude service whisper restart
claude service kokoro restart
```

### List Available Voices

```bash
claude list_tts_voices
```

## Configuration

Voice Mode is configured as an MCP (Model Context Protocol) server in Claude Code.

### MCP Configuration Location

- **User-level:** `~/.claude/mcp.json`
- **Project-level:** `.claude/mcp.json`

### Example Configuration

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

## Features

### Local Processing
- All speech recognition runs locally using Whisper
- All text-to-speech runs locally using Kokoro
- No data sent to external services
- Works offline

### Multiple Languages
Voice Mode supports multiple languages through Whisper's multilingual models.

### Real-time Interaction
- Low latency speech recognition
- Natural conversation flow
- Interrupt and resume support

## Troubleshooting

### No Audio Input Detected

```bash
# List audio devices
python3 -m sounddevice

# Test microphone (Ubuntu)
arecord -l  # List recording devices
arecord -d 5 test.wav  # Record 5 seconds
aplay test.wav  # Play back recording
```

### WSL2 Specific Issues

If using WSL2:

1. **Enable Windows microphone permissions** for your terminal app
2. **Check WSL version:** `wsl --version` (need 2.3.26.0+)
3. **Start PulseAudio:** `pulseaudio --start`
4. **Test audio devices:** `pactl list sources short`

See the [WSL2 microphone access guide](https://github.com/mbailey/voicemode/blob/main/docs/troubleshooting/wsl2-microphone-access.md)

### Service Not Starting

```bash
# View service logs
claude service whisper logs
claude service kokoro logs

# Check if ports are already in use
netstat -an | grep 8000  # Whisper default port
netstat -an | grep 8001  # Kokoro default port
```

### Connection Errors

```bash
# Verify services are running
claude voice_status

# Restart services
claude service whisper restart
claude service kokoro restart

# Enable debug mode
export CLAUDE_CODE_DEBUG=1
claude converse
```

## Advanced Configuration

### Custom Whisper Model

Edit your MCP configuration to specify a different Whisper model:

```json
{
  "mcpServers": {
    "voice-mode": {
      "command": "uvx",
      "args": ["voice-mode"],
      "env": {
        "WHISPER_MODEL": "medium"
      }
    }
  }
}
```

Available models: tiny, base, small, medium, large

### Custom TTS Voice

Configure the default voice in your settings:

```bash
export VOICE_MODE_DEFAULT_VOICE="en-us-male-1"
```

## Examples

### Dictation Workflow

1. Start voice mode: `claude converse`
2. Say: "Please help me write a function to sort an array"
3. Claude transcribes and responds with code
4. Continue refining with voice commands

### Code Review

1. Start voice mode: `claude converse`
2. Say: "Review the authentication code in src/auth.py"
3. Listen to Claude's voice response with suggestions
4. Discuss improvements via voice

## Resources

- [Voice Mode GitHub Repository](https://github.com/mbailey/voicemode)
- [MCP Protocol Documentation](https://modelcontextprotocol.io/)
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)

## Getting Help

1. Check service status: `claude voice_status`
2. View logs: `claude service whisper logs` and `claude service kokoro logs`
3. Review [troubleshooting section](#troubleshooting)
4. Check the [main troubleshooting guide](../../../docs/troubleshooting.md)
5. Open an issue on the Voice Mode GitHub repository
