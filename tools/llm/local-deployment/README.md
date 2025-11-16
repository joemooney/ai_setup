# Using Local and In-House LLMs with Claude Code

This guide explains how to configure Claude Code to work with local or in-house Large Language Models (LLMs) instead of the default Anthropic API. This is particularly useful for organizations with data sovereignty requirements, air-gapped environments, or those who want to use their own models.

## Overview

Claude Code can be configured to route requests through:
- Local LLM servers running on your machine
- In-house LLM deployments in your corporate data center
- Cloud-based LLM gateways within your organization's infrastructure
- Open-source models running locally (via compatible API servers)

## Architecture Options

### 1. Direct Local Model Integration
Run an LLM directly on your machine with an API-compatible server:
```
[Claude Code] → [Local API Server] → [Local LLM Model]
```

### 2. Corporate LLM Gateway
Route through a centralized gateway in your organization:
```
[Claude Code] → [Corporate Proxy] → [LLM Gateway] → [Multiple Models]
```

### 3. Hybrid Approach
Use local models for some tasks and cloud models for others:
```
[Claude Code] → [Router/Gateway] → [Local Models]
                                  → [Cloud Models]
```

## Configuration Methods

### Method 1: Environment Variables

The simplest way to redirect Claude Code to your local LLM:

```bash
# Point to your local LLM endpoint
export ANTHROPIC_BASE_URL=http://localhost:8080

# If your local server requires authentication
export ANTHROPIC_AUTH_TOKEN=your-local-token

# For corporate proxy environments
export HTTPS_PROXY=https://proxy.company.com:8080
```

### Method 2: Claude Code Settings

Create or modify `~/.claude/settings.json`:

```json
{
  "apiProvider": {
    "type": "custom",
    "baseUrl": "http://localhost:8080",
    "apiKey": "your-local-api-key"
  }
}
```

### Method 3: Using an LLM Gateway

For more complex setups with multiple models, use an LLM gateway like LiteLLM:

```bash
# Start your LLM gateway
litellm --model ollama/llama2 --port 8080

# Configure Claude Code
export ANTHROPIC_BASE_URL=http://localhost:8080
```

## Popular Local LLM Solutions

### 1. Ollama
Popular for running open-source models locally:

```bash
# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Run a model
ollama run llama2

# Start Ollama with Claude-compatible API
ollama serve
```

### 2. LocalAI
OpenAI-compatible API for local models:

```bash
# Run LocalAI with Docker
docker run -p 8080:8080 -v $PWD/models:/models localai/localai:latest

# Configure Claude Code
export ANTHROPIC_BASE_URL=http://localhost:8080/v1
```

### 3. Text Generation Web UI (oobabooga)
Feature-rich interface for various models:

```bash
# Clone and setup
git clone https://github.com/oobabooga/text-generation-webui
cd text-generation-webui
./start_linux.sh

# Enable API mode
# Add --api flag when starting
```

### 4. vLLM
High-performance inference server:

```bash
# Install vLLM
pip install vllm

# Start server with Claude-compatible endpoint
python -m vllm.entrypoints.openai.api_server \
  --model mistralai/Mistral-7B-v0.1 \
  --port 8080
```

## LLM Gateway Configuration

### LiteLLM Example

LiteLLM provides a unified interface for multiple LLM providers:

```yaml
# litellm_config.yaml
model_list:
  - model_name: claude-local
    litellm_params:
      model: ollama/llama2
      api_base: http://localhost:11434
  
  - model_name: gpt-local
    litellm_params:
      model: openai/gpt-3.5-turbo
      api_base: http://localhost:8080
```

Start the gateway:
```bash
litellm --config litellm_config.yaml --port 4000
```

Configure Claude Code:
```bash
export ANTHROPIC_BASE_URL=http://localhost:4000
```

## Corporate Deployment

### Setting Up an In-House Gateway

1. **Deploy the Gateway Server**
   ```bash
   # Example using LiteLLM in production
   docker run -d \
     -p 4000:4000 \
     -v ./config:/app/config \
     -e DATABASE_URL=postgresql://... \
     litellm/litellm:latest \
     --config /app/config/litellm.yaml
   ```

2. **Configure Authentication**
   ```yaml
   # config/litellm.yaml
   general_settings:
     master_key: sk-company-master-key
     database_url: ${DATABASE_URL}
   
   model_list:
     - model_name: company-llm
       litellm_params:
         model: azure/gpt-4
         api_base: https://company-llm.internal.com
         api_key: ${COMPANY_LLM_KEY}
   ```

3. **Configure Claude Code on Client Machines**
   ```bash
   # In user's .bashrc or .zshrc
   export ANTHROPIC_BASE_URL=https://llm-gateway.company.com
   export ANTHROPIC_AUTH_TOKEN=sk-user-specific-token
   ```

### Authentication Options

1. **Static API Keys**
   ```bash
   export ANTHROPIC_AUTH_TOKEN=sk-static-company-key
   ```

2. **Dynamic Token Generation**
   Create a helper script (`~/.claude/get-token.sh`):
   ```bash
   #!/bin/bash
   # Fetch token from corporate auth service
   curl -s https://auth.company.com/token \
     -H "Authorization: Bearer $(cat ~/.company/creds)" \
     | jq -r .token
   ```

   Configure in settings:
   ```json
   {
     "apiKeyHelper": "~/.claude/get-token.sh",
     "apiKeyRefreshInterval": 3600
   }
   ```

## API Compatibility Layer

If your local LLM doesn't support Claude's API format, create a translation layer:

```python
# api_translator.py
from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

@app.route('/v1/messages', methods=['POST'])
def translate_claude_to_local():
    claude_request = request.json
    
    # Translate to your local LLM format
    local_request = {
        "prompt": claude_request.get("messages", [])[-1].get("content"),
        "max_tokens": claude_request.get("max_tokens", 1000),
        "temperature": claude_request.get("temperature", 0.7)
    }
    
    # Call your local LLM
    response = requests.post(
        "http://localhost:8080/generate",
        json=local_request
    )
    
    # Translate response back to Claude format
    return jsonify({
        "content": [{
            "type": "text",
            "text": response.json()["generated_text"]
        }],
        "model": "local-llm",
        "usage": {
            "input_tokens": 100,
            "output_tokens": 150
        }
    })

if __name__ == '__main__':
    app.run(port=5000)
```

## Performance Optimization

### 1. Model Selection
- For coding tasks: CodeLlama, Deepseek Coder, or StarCoder
- For general tasks: Llama 2/3, Mistral, or Mixtral
- For fast inference: Smaller models like Phi-2 or TinyLlama

### 2. Hardware Acceleration
```bash
# For NVIDIA GPUs
export CUDA_VISIBLE_DEVICES=0

# For Apple Silicon
export GGML_METAL=1

# For CPU optimization
export OMP_NUM_THREADS=8
```

### 3. Quantization
Use quantized models for better performance:
```bash
# Example with llama.cpp
./quantize model.gguf model-q4_k_m.gguf q4_k_m
```

## Troubleshooting

### Common Issues

1. **Connection Refused**
   ```bash
   # Check if your local server is running
   curl http://localhost:8080/health
   
   # Verify the port is correct
   netstat -an | grep 8080
   ```

2. **Authentication Errors**
   ```bash
   # Test your token
   curl -H "Authorization: Bearer $ANTHROPIC_AUTH_TOKEN" \
     $ANTHROPIC_BASE_URL/models
   ```

3. **SSL Certificate Issues**
   ```bash
   # For self-signed certificates
   export NODE_TLS_REJECT_UNAUTHORIZED=0
   
   # Or provide your CA certificate
   export SSL_CERT_FILE=/path/to/ca-cert.pem
   ```

4. **Response Format Mismatch**
   - Enable debug logging to see raw responses
   - Use an API translation layer if needed
   - Check model compatibility with Claude's format

### Debug Mode

Enable verbose logging:
```bash
export CLAUDE_CODE_DEBUG=1
export ANTHROPIC_LOG_LEVEL=debug
```

## Security Considerations

1. **Network Security**
   - Use HTTPS for all endpoints
   - Implement proper firewall rules
   - Consider VPN for remote access

2. **Authentication**
   - Rotate API keys regularly
   - Use short-lived tokens when possible
   - Implement rate limiting

3. **Data Privacy**
   - Ensure logs don't contain sensitive data
   - Implement data retention policies
   - Use encryption at rest and in transit

## Example Configurations

### Development Setup (Local Ollama)
```bash
# ~/.bashrc
export ANTHROPIC_BASE_URL=http://localhost:11434/v1
export ANTHROPIC_AUTH_TOKEN=ollama-local
```

### Corporate Setup (With Proxy)
```bash
# ~/.bashrc
export HTTPS_PROXY=https://proxy.company.com:8080
export ANTHROPIC_BASE_URL=https://llm.company.internal
export ANTHROPIC_AUTH_TOKEN_HELPER=~/.claude/get-corp-token.sh
```

### Hybrid Setup (Gateway with Fallback)
```bash
# ~/.bashrc
export ANTHROPIC_BASE_URL=http://localhost:4000
export ANTHROPIC_FALLBACK_URL=https://api.anthropic.com
```

## Testing Your Configuration

Test that Claude Code can connect to your local LLM:

```bash
# Simple test
claude "What is 2+2?"

# Test with specific model
ANTHROPIC_MODEL=local-llama2 claude "Explain quantum computing"

# Verify the endpoint being used
CLAUDE_CODE_DEBUG=1 claude "Hello" 2>&1 | grep "Request URL"
```

## Additional Resources

- [LiteLLM Documentation](https://docs.litellm.ai/)
- [Ollama Documentation](https://ollama.ai/docs)
- [LocalAI GitHub](https://github.com/mudler/LocalAI)
- [vLLM Documentation](https://vllm.readthedocs.io/)
- [Claude Code Settings Reference](https://docs.anthropic.com/en/docs/claude-code/settings)

Remember to check your organization's policies regarding LLM usage and data handling before implementing any of these solutions.