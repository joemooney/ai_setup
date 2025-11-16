# AI Setup Environment Variables
# Add this to your ~/.bashrc or ~/.zshrc

# === LLM Configuration ===

# Option 1: Use Ollama locally
export ANTHROPIC_BASE_URL=http://localhost:11434/v1
export ANTHROPIC_AUTH_TOKEN=ollama-local

# Option 2: Use LocalAI
# export ANTHROPIC_BASE_URL=http://localhost:8080/v1
# export ANTHROPIC_AUTH_TOKEN=local-api-key

# Option 3: Use corporate LLM gateway
# export ANTHROPIC_BASE_URL=https://llm.company.com
# export ANTHROPIC_AUTH_TOKEN_HELPER=~/.claude/get-corp-token.sh

# === Voice Mode Configuration ===

# Default voice for TTS
export VOICE_MODE_DEFAULT_VOICE="en-us-female-1"

# Whisper model size (tiny, base, small, medium, large)
export WHISPER_MODEL="base"

# === Performance Tuning ===

# GPU selection (if multiple GPUs)
export CUDA_VISIBLE_DEVICES=0

# CPU thread count for inference
export OMP_NUM_THREADS=8

# === Aliases ===

# Quick access to setup menu
alias ai-setup='cd ~/ai/ai_setup && ./setup.sh'

# Claude with local LLM
alias claude-local='ANTHROPIC_BASE_URL=http://localhost:11434/v1 claude'

# Claude with cloud (default Anthropic)
alias claude-cloud='unset ANTHROPIC_BASE_URL && claude'

# === Model Management ===

# Custom model storage location (if needed)
# export OLLAMA_MODELS=/mnt/large-disk/ollama-models

# === Debug Mode ===

# Uncomment to enable debug logging
# export CLAUDE_CODE_DEBUG=1
# export OLLAMA_DEBUG=1
