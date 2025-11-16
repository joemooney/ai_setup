# Best Practices & Lessons Learned

This document captures best practices, lessons learned, and recommendations for setting up and using AI agents on Ubuntu.

## General Principles

### 1. Start Local, Scale Gradually

- Begin with local installations to understand the tools
- Test thoroughly before deploying to production
- Consider resource requirements early

### 2. Security First

- Use local models for sensitive data
- Implement proper authentication for multi-user setups
- Keep credentials out of version control
- Regularly update dependencies

### 3. Document Everything

- Keep notes on configuration changes
- Document custom integrations
- Track which models work best for your use cases
- Maintain a changelog for your setup

## Speech & Dictation

### Choosing the Right Tool

**Use Whisper standalone when:**
- You only need transcription
- You want minimal dependencies
- You're building custom workflows

**Use Voice Mode when:**
- You use Claude Code regularly
- You want bidirectional voice conversation
- You need integrated TTS
- You want the simplest setup

### Audio Setup

**Lessons Learned:**

1. **Test audio devices first**
   ```bash
   python3 -m sounddevice
   arecord -l
   ```
   Don't skip this step - most issues stem from audio configuration.

2. **WSL2 requires special attention**
   - Check WSL version (need 2.3.26.0+)
   - Enable Windows microphone permissions
   - Start PulseAudio explicitly
   - Test with `pactl list sources short`

3. **Model size matters**
   - Tiny: Fast, but less accurate
   - Base: Good balance for real-time
   - Small/Medium: Better accuracy, slower
   - Large: Best quality, resource intensive

4. **Background noise**
   - Use a decent microphone
   - Consider noise cancellation
   - Test in your actual working environment

## LLM Deployment

### Model Selection

**Lessons Learned:**

1. **Start with quantized models**
   - Q4 models offer 80-90% of performance at 25% of size
   - Q8 for better quality if you have the VRAM
   - FP16 only if you have abundant resources

2. **Match model to task**
   - Coding: CodeLlama, Deepseek Coder
   - General chat: Llama 2/3, Mistral
   - Fast responses: Phi-2, TinyLlama

3. **Hardware considerations**
   - CPU inference: Usable for 7B models
   - GPU: Essential for 13B+ models
   - Apple Silicon: Excellent performance with Metal

### Infrastructure

**Best Practices:**

1. **Use a gateway for multiple models**
   - LiteLLM provides unified interface
   - Easy to switch between models
   - Centralized logging and monitoring

2. **Monitor resource usage**
   ```bash
   # GPU usage
   nvidia-smi -l 1

   # Memory
   htop

   # Disk I/O
   iotop
   ```

3. **Set up health checks**
   - Monitor API endpoint response times
   - Alert on high memory usage
   - Track model loading times

4. **Plan for model storage**
   - Models range from 2GB to 100GB+
   - Keep commonly used models on SSD
   - Archive unused models

### Performance Optimization

**Lessons Learned:**

1. **Context length vs speed**
   - Longer context = slower inference
   - Use appropriate context window for task
   - Consider chunking for long documents

2. **Batch size tuning**
   - Larger batches = better throughput
   - Smaller batches = lower latency
   - Adjust based on your use case

3. **Caching**
   - Enable KV cache for conversations
   - Cache common prompts
   - Pre-load frequently used models

## Claude Code Integration

### Configuration

**Best Practices:**

1. **Use environment variables for flexibility**
   ```bash
   # In ~/.bashrc or ~/.zshrc
   export ANTHROPIC_BASE_URL=http://localhost:11434/v1
   export ANTHROPIC_AUTH_TOKEN=$(cat ~/.tokens/local-llm)
   ```

2. **Create profiles for different setups**
   ```bash
   # ~/.bash_aliases
   alias claude-local='ANTHROPIC_BASE_URL=http://localhost:11434/v1 claude'
   alias claude-remote='ANTHROPIC_BASE_URL=https://llm.company.com claude'
   ```

3. **Test configuration**
   ```bash
   CLAUDE_CODE_DEBUG=1 claude "test" 2>&1 | grep "Request URL"
   ```

### Workflow Integration

**Lessons Learned:**

1. **Use .claudeignore effectively**
   - Exclude build artifacts
   - Skip large binary files
   - Ignore sensitive data

2. **Leverage MCP servers**
   - Voice Mode for dictation
   - Custom tools via MCP protocol
   - Context providers for better responses

3. **Git integration**
   - Commit frequently when using AI assistance
   - Review AI-generated code carefully
   - Use branches for experimental changes

## Security & Privacy

### Data Protection

**Best Practices:**

1. **Use local models for sensitive data**
   - Company proprietary code
   - Personal information
   - Confidential documents

2. **Network isolation**
   - Run local models on isolated networks
   - Use VPNs for remote access
   - Implement firewall rules

3. **Audit logging**
   - Log all API requests
   - Monitor for unusual patterns
   - Retain logs per policy requirements

### Authentication

**Lessons Learned:**

1. **Rotate credentials regularly**
   - API keys every 90 days
   - Use short-lived tokens when possible
   - Implement automatic rotation

2. **Use credential helpers**
   ```bash
   # ~/.claude/get-token.sh
   #!/bin/bash
   # Fetch from secure credential store
   ```

3. **Separate dev and prod credentials**
   - Different tokens for each environment
   - Test with limited-scope tokens
   - Never commit credentials

## Common Pitfalls

### Avoid These Mistakes

1. **Not testing audio setup first**
   - Always test microphone before installing speech tools
   - Verify audio devices work in your environment

2. **Underestimating resource requirements**
   - Check RAM/VRAM before downloading models
   - Monitor resource usage during testing
   - Plan for peak load, not average

3. **Skipping security configuration**
   - Default credentials are not secure
   - Network services need authentication
   - Update regularly for security patches

4. **Not documenting customizations**
   - Custom configs get lost
   - Hard to reproduce setups
   - Difficult to troubleshoot later

5. **Ignoring model licensing**
   - Check license terms before using models
   - Respect usage restrictions
   - Consider commercial licensing needs

## Maintenance

### Regular Tasks

**Weekly:**
- Check service health
- Review logs for errors
- Monitor disk usage

**Monthly:**
- Update dependencies
- Rotate credentials
- Review and archive old models
- Check for security updates

**Quarterly:**
- Audit access logs
- Review and update documentation
- Test disaster recovery procedures
- Evaluate new models/tools

## Performance Benchmarking

### Metrics to Track

1. **Response time**
   - Time to first token
   - Total response time
   - 95th percentile latency

2. **Resource usage**
   - CPU utilization
   - Memory consumption
   - GPU VRAM usage
   - Disk I/O

3. **Accuracy**
   - Task completion rate
   - Error frequency
   - User satisfaction

### Tools

```bash
# Response time
time curl http://localhost:8080/v1/chat/completions -d '...'

# Resource usage
nvidia-smi --query-gpu=utilization.gpu,memory.used --format=csv -l 1

# Load testing
ab -n 100 -c 10 http://localhost:8080/health
```

## Cost Optimization

### For Local Deployments

1. **Use appropriate model sizes**
   - Don't use 70B when 7B suffices
   - Quantize aggressively when possible

2. **Share resources**
   - One inference server for multiple users
   - Load models on-demand
   - Unload unused models

3. **Optimize compute**
   - Use GPU for larger models
   - CPU for small models during off-peak
   - Consider cloud GPU for occasional large tasks

## Getting Help

When things go wrong:

1. Check the [troubleshooting guide](troubleshooting.md)
2. Review tool-specific documentation
3. Enable debug logging
4. Search GitHub issues for similar problems
5. Ask in community forums with:
   - Exact error messages
   - Your configuration
   - Steps to reproduce
   - Environment details (OS, versions, hardware)

## Contributing Your Lessons

Found something that works well? Ran into an issue and solved it? Please contribute:

1. Document your finding
2. Add it to the appropriate section
3. Submit a pull request
4. Help others avoid the same pitfalls

## Additional Resources

- [Official Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Ollama Documentation](https://ollama.ai/docs)
- [Whisper Documentation](https://github.com/openai/whisper)
- [Voice Mode GitHub](https://github.com/mbailey/voicemode)
