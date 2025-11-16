# Speech & Dictation Tools

Tools and configurations for speech recognition, text-to-speech, and dictation on Ubuntu.

## Available Tools

### [OpenAI Whisper](whisper/)

Local, offline speech recognition using OpenAI's Whisper model.

**Features:**
- Runs completely offline
- High accuracy
- Multiple language support
- Various model sizes (tiny to large)

**Use Cases:**
- Transcription
- Voice commands
- Accessibility

[View Whisper Setup Guide →](whisper/README.md)

### [Voice Mode](voice-mode/)

Voice interface for Claude Code with real-time speech-to-text and text-to-speech.

**Features:**
- Real-time voice conversation with Claude
- Local Whisper for STT
- Local Kokoro for TTS
- Works offline
- Supports multiple languages

**Use Cases:**
- Hands-free coding assistance
- Voice-driven development
- Accessibility

[View Voice Mode Setup Guide →](voice-mode/README.md)

### [General Dictation Setup](dictation/)

Comprehensive guide for setting up dictation on Ubuntu using the tools above.

**Covers:**
- Choosing between Whisper and Voice Mode
- Configuration tips
- Troubleshooting
- WSL2 support

[View Dictation Guide →](dictation/README.md)

## Quick Start

### For Claude Code Users (Recommended)

Install Voice Mode for the best integrated experience:

```bash
cd voice-mode
./install.sh
```

### For Standalone Dictation

Set up OpenAI Whisper:

```bash
cd whisper
# Follow the installation instructions in README.md
```

## Comparison

| Feature | Whisper | Voice Mode |
|---------|---------|------------|
| Offline | ✅ | ✅ |
| Claude Integration | ❌ | ✅ |
| TTS (Speech Output) | ❌ | ✅ |
| Standalone Use | ✅ | ❌ |
| Setup Complexity | Low | Medium |

## Common Prerequisites

Most speech tools require:

- Python 3.8+
- Working microphone
- Audio libraries (portaudio, ffmpeg)
- For WSL2: Additional audio configuration

See individual tool guides for specific requirements.

## Troubleshooting

For common issues across all speech tools, see the [main troubleshooting guide](../../docs/troubleshooting.md).

For tool-specific issues, check the individual README files.
