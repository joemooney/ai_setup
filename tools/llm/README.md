# Large Language Model (LLM) Tools

Tools and configurations for running and integrating Large Language Models locally and with Claude Code.

## Available Tools

### [Local LLM Deployment](local-deployment/)

Comprehensive guide for running LLMs locally on your machine or in your data center.

**Supported Platforms:**
- **Ollama** - Easy-to-use local LLM runner
- **LocalAI** - OpenAI-compatible local API server
- **vLLM** - High-performance inference server
- **LiteLLM** - Universal LLM gateway/proxy

**Use Cases:**
- Data sovereignty and privacy
- Air-gapped environments
- Cost reduction
- Custom model deployment
- Development and testing

[View Local Deployment Guide →](local-deployment/README.md)

### [Claude Code Integration](claude-code/)

Configure Claude Code to work with local or corporate LLM endpoints.

**Features:**
- Route Claude Code through local LLMs
- Corporate proxy support
- Authentication configuration
- API translation layers

**Use Cases:**
- Using Claude Code with in-house models
- Development against local LLMs
- Testing and experimentation

[View Claude Code Integration Guide →](claude-code/README.md)

## Quick Start

### Run Ollama Locally

The easiest way to get started with local LLMs:

```bash
# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Run a model
ollama run llama2

# Configure Claude Code to use it
export ANTHROPIC_BASE_URL=http://localhost:11434/v1
```

### For Corporate Deployments

See the [Local Deployment Guide](local-deployment/README.md) for:
- Setting up LLM gateways
- Authentication and security
- Multi-model routing
- Performance optimization

## Architecture Patterns

### 1. Direct Local Model
```
[Claude Code] → [Local API Server] → [Local LLM Model]
```

### 2. Corporate Gateway
```
[Claude Code] → [Corporate Proxy] → [LLM Gateway] → [Multiple Models]
```

### 3. Hybrid Approach
```
[Claude Code] → [Router/Gateway] → [Local Models]
                                  → [Cloud Models]
```

## Model Recommendations

### For Coding Tasks
- CodeLlama (7B, 13B, 34B)
- Deepseek Coder
- StarCoder
- WizardCoder

### For General Tasks
- Llama 2/3 (7B, 13B, 70B)
- Mistral (7B)
- Mixtral (8x7B)

### For Fast Inference
- Phi-2
- TinyLlama
- Quantized versions of larger models

## Hardware Requirements

| Model Size | RAM (CPU) | VRAM (GPU) | Performance |
|------------|-----------|------------|-------------|
| 7B (Q4) | 8GB | 6GB | Good |
| 13B (Q4) | 16GB | 10GB | Better |
| 70B (Q4) | 64GB | 40GB | Best |

*Q4 = 4-bit quantization*

## Common Prerequisites

- Python 3.8+
- Docker (for some deployments)
- CUDA toolkit (for GPU acceleration)
- 8GB+ RAM minimum
- Storage for models (2GB - 100GB+ depending on model)

## Troubleshooting

For common LLM setup issues, see:
- [Local Deployment Troubleshooting](local-deployment/README.md#troubleshooting)
- [Main Troubleshooting Guide](../../docs/troubleshooting.md)
