# Dictation Setup for Ubuntu

You have two excellent options for dictation on Ubuntu, both already configured in this repository:

## Option 1: Voice Mode (Recommended - Already Installed!)

Voice Mode provides real-time dictation with Claude Code integration.

### Usage

1. **Interactive Voice Conversation:**
   ```bash
   claude converse
   ```
   This opens an interactive voice session where you can speak and Claude will respond.

2. **Direct Dictation in Claude:**
   Use the `converse` tool within Claude to dictate text. Claude will transcribe your speech.

### Features
- Real-time speech-to-text using local Whisper
- Text-to-speech responses
- Works offline (uses local services)
- Supports multiple languages

### Testing Your Setup
```bash
# Check if services are running
claude voice_status

# View available voices
claude list_tts_voices
```

## Option 2: Standalone Whisper (For Pure Dictation)

If you prefer standalone dictation without Claude integration:

### Setup
```bash
# Activate Whisper environment
source whisper-env/bin/activate

# Install Whisper (if not already installed)
pip install -U openai-whisper pyaudio
```

### Basic Dictation Script

Create a file `dictate.py`:

```python
import whisper
import pyaudio
import wave
import numpy as np
import tempfile
import os

def record_audio(duration=10, sample_rate=16000):
    """Record audio from microphone"""
    chunk = 1024
    format = pyaudio.paInt16
    channels = 1
    
    p = pyaudio.PyAudio()
    
    stream = p.open(format=format,
                    channels=channels,
                    rate=sample_rate,
                    input=True,
                    frames_per_buffer=chunk)
    
    print(f"Recording for {duration} seconds...")
    frames = []
    
    for _ in range(0, int(sample_rate / chunk * duration)):
        data = stream.read(chunk)
        frames.append(data)
    
    print("Recording finished")
    
    stream.stop_stream()
    stream.close()
    p.terminate()
    
    return b''.join(frames), sample_rate

def transcribe_audio(audio_data, sample_rate):
    """Transcribe audio using Whisper"""
    # Save to temporary file
    with tempfile.NamedTemporaryFile(suffix='.wav', delete=False) as tmp_file:
        wf = wave.open(tmp_file.name, 'wb')
        wf.setnchannels(1)
        wf.setsampwidth(2)
        wf.setframerate(sample_rate)
        wf.writeframes(audio_data)
        wf.close()
        
        # Load model and transcribe
        model = whisper.load_model("base")
        result = model.transcribe(tmp_file.name)
        
        # Clean up
        os.unlink(tmp_file.name)
        
        return result["text"]

if __name__ == "__main__":
    # Record and transcribe
    audio_data, sample_rate = record_audio(duration=10)
    text = transcribe_audio(audio_data, sample_rate)
    print(f"\nTranscription: {text}")
```

### Usage
```bash
# Activate environment
source whisper-env/bin/activate

# Run dictation
python dictate.py
```

## Troubleshooting

### No Audio Input Detected
```bash
# List audio devices
python -m sounddevice

# Test microphone
arecord -l  # List recording devices
arecord -d 5 test.wav  # Record 5 seconds
aplay test.wav  # Play back recording
```

### WSL2 Users
If using WSL2, ensure:
1. Windows microphone permissions are enabled for your terminal
2. PulseAudio is running: `pulseaudio --start`
3. WSL version is 2.3.26.0 or higher: `wsl --version`

### Voice Mode Issues
```bash
# Check service status
claude service whisper status
claude service kokoro status

# Restart services if needed
claude service whisper restart
claude service kokoro restart
```

## Quick Start

For immediate dictation, just run:
```bash
claude converse
```

Then speak when prompted. Your speech will be transcribed and you can have a conversation with Claude using voice!