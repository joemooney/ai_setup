# Troubleshooting Guide

Common issues and solutions for AI agent setup and configuration on Ubuntu.

## Table of Contents

- [Audio & Speech Recognition](#audio--speech-recognition)
- [Voice Mode](#voice-mode)
- [LLM Deployment](#llm-deployment)
- [Claude Code Integration](#claude-code-integration)
- [WSL2 Specific Issues](#wsl2-specific-issues)
- [Network & Connectivity](#network--connectivity)
- [Performance Issues](#performance-issues)

## Audio & Speech Recognition

### No Microphone Detected

**Symptoms:**
- Audio tools can't find input device
- Empty list when running `python3 -m sounddevice`

**Solutions:**

1. Check if microphone is connected:
   ```bash
   arecord -l
   ```

2. Test microphone:
   ```bash
   arecord -d 5 test.wav
   aplay test.wav
   ```

3. Check PulseAudio:
   ```bash
   pulseaudio --check
   pulseaudio --start
   pactl list sources short
   ```

4. Verify permissions:
   ```bash
   # Add user to audio group
   sudo usermod -a -G audio $USER
   # Log out and back in for changes to take effect
   ```

### Poor Audio Quality / Transcription Errors

**Symptoms:**
- Whisper produces incorrect transcriptions
- Words are garbled or missing

**Solutions:**

1. Test microphone quality:
   ```bash
   arecord -f cd -d 10 test.wav
   aplay test.wav
   # Listen for clarity
   ```

2. Check background noise:
   - Move to quieter location
   - Use better microphone
   - Enable noise cancellation if available

3. Try a larger Whisper model:
   ```bash
   # Instead of 'tiny' or 'base', use 'small' or 'medium'
   whisper audio.wav --model medium
   ```

4. Check audio input level:
   ```bash
   alsamixer
   # Press F4 to select capture device
   # Increase input level
   ```

### PortAudio Errors

**Symptoms:**
```
OSError: PortAudio library not found
```

**Solutions:**

1. Install PortAudio:
   ```bash
   sudo apt update
   sudo apt install portaudio19-dev python3-pyaudio
   ```

2. Reinstall PyAudio:
   ```bash
   pip uninstall pyaudio
   pip install pyaudio
   ```

## Voice Mode

### Services Won't Start

**Symptoms:**
- `claude voice_status` shows services as stopped
- Services immediately crash after starting

**Solutions:**

1. Check service logs:
   ```bash
   claude service whisper logs
   claude service kokoro logs
   ```

2. Verify ports are available:
   ```bash
   # Check if ports 8000 and 8001 are in use
   netstat -an | grep 8000
   netstat -an | grep 8001
   ```

3. Check Python environment:
   ```bash
   which python3
   python3 --version  # Need 3.8+
   ```

4. Reinstall services:
   ```bash
   claude service whisper stop
   uvx --reinstall voice-mode
   ```

### Connection Timeout

**Symptoms:**
```
Error: Connection to Whisper service timed out
```

**Solutions:**

1. Verify services are running:
   ```bash
   claude voice_status
   ```

2. Check firewall:
   ```bash
   sudo ufw status
   sudo ufw allow 8000
   sudo ufw allow 8001
   ```

3. Test direct connection:
   ```bash
   curl http://localhost:8000/health
   curl http://localhost:8001/health
   ```

4. Restart services:
   ```bash
   claude service whisper restart
   claude service kokoro restart
   ```

### No Audio Output (TTS Not Working)

**Symptoms:**
- Transcription works but no speech output
- Kokoro service running but silent

**Solutions:**

1. Test system audio:
   ```bash
   speaker-test -t wav -c 2
   ```

2. Check PulseAudio output:
   ```bash
   pactl list sinks short
   pacmd set-default-sink 0
   ```

3. Verify Kokoro service:
   ```bash
   claude service kokoro status
   claude service kokoro logs
   ```

4. Test TTS directly:
   ```bash
   curl -X POST http://localhost:8001/speak \
     -H "Content-Type: application/json" \
     -d '{"text": "Hello world"}'
   ```

## LLM Deployment

### Out of Memory (OOM)

**Symptoms:**
```
CUDA out of memory
RuntimeError: [enforce fail at alloc_cpu.cpp:...]
```

**Solutions:**

1. Use smaller model:
   ```bash
   # Instead of 13B, try 7B
   ollama run llama2:7b
   ```

2. Use quantized model:
   ```bash
   # Use Q4 quantization instead of FP16
   ollama run llama2:7b-q4_0
   ```

3. Reduce context length:
   ```bash
   # In your configuration
   export MAX_CONTEXT_LENGTH=2048  # Instead of 4096
   ```

4. Monitor memory:
   ```bash
   # GPU
   nvidia-smi -l 1

   # RAM
   watch -n 1 free -h
   ```

### Model Download Fails

**Symptoms:**
- Download interrupted
- Checksum mismatch
- Partial model files

**Solutions:**

1. Check disk space:
   ```bash
   df -h
   # Models can be 2-100GB
   ```

2. Retry download:
   ```bash
   # Ollama automatically resumes
   ollama pull llama2

   # Or manually clean and retry
   rm -rf ~/.ollama/models/llama2
   ollama pull llama2
   ```

3. Check internet connection:
   ```bash
   curl -I https://ollama.ai
   ```

4. Use alternative download location:
   ```bash
   export OLLAMA_MODELS=/mnt/large-disk/ollama-models
   ollama pull llama2
   ```

### Slow Inference

**Symptoms:**
- Very long response times (>30s for simple queries)
- High CPU usage with GPU available

**Solutions:**

1. Verify GPU usage:
   ```bash
   nvidia-smi
   # Check if GPU utilization is >0%
   ```

2. Enable GPU acceleration:
   ```bash
   # For Ollama
   export OLLAMA_CUDA_VISIBLE_DEVICES=0

   # For vLLM
   export CUDA_VISIBLE_DEVICES=0
   ```

3. Check model loaded in VRAM:
   ```bash
   nvidia-smi
   # Check memory usage
   ```

4. Reduce batch size if memory-constrained:
   ```bash
   # In model config
   export BATCH_SIZE=1
   ```

5. Use faster model:
   ```bash
   # Smaller models are faster
   ollama run phi:2.7b  # Instead of llama2:70b
   ```

## Claude Code Integration

### Authentication Errors

**Symptoms:**
```
Error: Invalid API key
Error: Unauthorized
```

**Solutions:**

1. Check API key format:
   ```bash
   echo $ANTHROPIC_AUTH_TOKEN
   # Should not be empty
   ```

2. Verify endpoint:
   ```bash
   echo $ANTHROPIC_BASE_URL
   # Should point to your LLM server
   ```

3. Test authentication manually:
   ```bash
   curl -H "Authorization: Bearer $ANTHROPIC_AUTH_TOKEN" \
     $ANTHROPIC_BASE_URL/health
   ```

4. Check Claude Code config:
   ```bash
   cat ~/.claude/settings.json
   ```

### Wrong Model Responding

**Symptoms:**
- Expected local model but getting cloud responses
- Wrong model in responses

**Solutions:**

1. Verify environment variables:
   ```bash
   env | grep ANTHROPIC
   ```

2. Check Claude Code is using custom endpoint:
   ```bash
   CLAUDE_CODE_DEBUG=1 claude "test" 2>&1 | grep "Request URL"
   ```

3. Ensure env vars are exported:
   ```bash
   # In ~/.bashrc or ~/.zshrc
   export ANTHROPIC_BASE_URL=http://localhost:11434/v1

   # Then reload
   source ~/.bashrc
   ```

### API Compatibility Issues

**Symptoms:**
```
Error: Unexpected response format
Error: Invalid request body
```

**Solutions:**

1. Check API compatibility:
   ```bash
   # Your local server must implement OpenAI-compatible API
   curl http://localhost:8080/v1/models
   ```

2. Use API translation layer (see Local_LLM.md)

3. Check model supports required features:
   ```bash
   # Some models don't support streaming
   # Some don't support function calling
   ```

4. Enable debug mode:
   ```bash
   export CLAUDE_CODE_DEBUG=1
   claude "test"
   ```

## WSL2 Specific Issues

### No Audio Devices in WSL2

**Symptoms:**
- `arecord -l` shows no devices
- PulseAudio finds no sources

**Solutions:**

1. Check WSL version:
   ```bash
   wsl --version
   # Need 2.3.26.0 or higher for audio support
   ```

2. Update WSL:
   ```powershell
   # In Windows PowerShell
   wsl --update
   wsl --shutdown
   # Restart WSL
   ```

3. Enable Windows microphone permissions:
   - Settings → Privacy → Microphone
   - Enable for Windows Terminal / your terminal app

4. Start PulseAudio:
   ```bash
   pulseaudio --start
   pactl list sources short
   ```

5. Install WSL audio packages:
   ```bash
   sudo apt install pulseaudio pulseaudio-utils libasound2-plugins
   ```

### WSL2 Performance Issues

**Symptoms:**
- Very slow compared to native Linux
- High CPU usage

**Solutions:**

1. Check WSL2 resource limits:
   ```powershell
   # Create/edit C:\Users\<YourName>\.wslconfig
   [wsl2]
   memory=16GB
   processors=8
   ```

2. Restart WSL:
   ```powershell
   wsl --shutdown
   ```

3. Use native Windows tools for GPU:
   - Consider running GPU workloads in Windows
   - WSL2 GPU support is improving but may have overhead

## Network & Connectivity

### Connection Refused

**Symptoms:**
```
Error: Connection refused to localhost:8080
```

**Solutions:**

1. Verify service is running:
   ```bash
   netstat -an | grep 8080
   ps aux | grep ollama
   ```

2. Check correct port:
   ```bash
   # Ollama default: 11434
   # LocalAI default: 8080
   # Custom: check your config
   ```

3. Try 127.0.0.1 instead of localhost:
   ```bash
   export ANTHROPIC_BASE_URL=http://127.0.0.1:11434/v1
   ```

4. Check firewall:
   ```bash
   sudo ufw status
   sudo ufw allow 8080
   ```

### SSL Certificate Errors

**Symptoms:**
```
Error: SSL certificate verification failed
```

**Solutions:**

1. For development, disable verification (not recommended for production):
   ```bash
   export NODE_TLS_REJECT_UNAUTHORIZED=0
   ```

2. Add CA certificate:
   ```bash
   export SSL_CERT_FILE=/path/to/ca-cert.pem
   ```

3. Use HTTP instead of HTTPS for local:
   ```bash
   export ANTHROPIC_BASE_URL=http://localhost:8080  # Not https://
   ```

## Performance Issues

### High CPU Usage

**Symptoms:**
- CPU at 100% constantly
- System becomes unresponsive

**Solutions:**

1. Check what's using CPU:
   ```bash
   top
   # Press Shift+P to sort by CPU
   ```

2. Reduce concurrent requests:
   ```bash
   # Limit model inference threads
   export OMP_NUM_THREADS=4
   ```

3. Use GPU instead:
   ```bash
   # Offload to GPU if available
   export CUDA_VISIBLE_DEVICES=0
   ```

4. Use lighter model:
   ```bash
   ollama run phi:2.7b  # Much lighter than llama2:70b
   ```

### Disk Space Issues

**Symptoms:**
```
Error: No space left on device
```

**Solutions:**

1. Check disk usage:
   ```bash
   df -h
   du -sh ~/.ollama/models/*
   ```

2. Remove unused models:
   ```bash
   ollama list
   ollama rm unused-model
   ```

3. Move models to larger disk:
   ```bash
   export OLLAMA_MODELS=/mnt/large-disk/models
   ```

4. Clean Docker images (if using LocalAI):
   ```bash
   docker system prune -a
   ```

## Getting More Help

If you've tried these solutions and still have issues:

1. **Enable debug logging:**
   ```bash
   export CLAUDE_CODE_DEBUG=1
   export OLLAMA_DEBUG=1
   # Run your command again
   ```

2. **Gather information:**
   - Exact error message
   - Output of `uname -a`
   - Output of relevant `--version` commands
   - Steps to reproduce

3. **Check logs:**
   - Claude Code: Enable debug mode
   - System logs: `journalctl -xe`
   - Application logs: Check tool-specific log locations

4. **Search existing issues:**
   - [Claude Code GitHub](https://github.com/anthropics/claude-code/issues)
   - [Ollama GitHub](https://github.com/ollama/ollama/issues)
   - [Voice Mode GitHub](https://github.com/mbailey/voicemode/issues)

5. **Community support:**
   - Ask in tool-specific Discord/Slack channels
   - Post on relevant subreddits
   - Stack Overflow with appropriate tags

6. **File a bug report:**
   - Include debug logs
   - Provide system information
   - List steps to reproduce
   - Describe expected vs actual behavior
