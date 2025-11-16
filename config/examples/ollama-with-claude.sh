#!/bin/bash
# Example: Configure Claude Code to use Ollama

# Set Ollama as the LLM endpoint for Claude Code
export ANTHROPIC_BASE_URL=http://localhost:11434/v1

# Ollama doesn't require authentication for local use
export ANTHROPIC_AUTH_TOKEN=ollama-local

# Optional: Specify model
export ANTHROPIC_MODEL=llama2

# Test the configuration
echo "Testing Ollama connection..."
curl -s http://localhost:11434/api/tags | head -n 20

echo ""
echo "Configuration set. Now you can run:"
echo "  claude 'What is the capital of France?'"
