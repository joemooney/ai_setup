# PROMPT_HISTORY.md

This file tracks all development sessions for the AI Setup repository.

## Session 1 - Initial Repository Creation (2025-08-03)

### Request: Test voice conversation feature
- Tested the voice conversation capabilities using the `converse` tool
- Had a conversation about voice mode privacy and data handling
- Discussed how voice is processed locally (Whisper for STT, Kokoro for TTS)
- User mentioned having an in-house cloud infrastructure

### Request: Create documentation for using local LLMs
- User requested: "if you can create a write up on how to use local LLMs that would be great. Please store in Local_LLM.md"
- Actions taken:
  1. Researched Claude Code documentation for LLM gateway and corporate proxy support
  2. Created comprehensive `Local_LLM.md` guide covering:
     - Overview of local LLM integration options
     - Architecture patterns (direct, gateway, hybrid)
     - Configuration methods (env vars, settings.json, LLM gateways)
     - Popular local LLM solutions (Ollama, LocalAI, oobabooga, vLLM)
     - Corporate deployment guidelines
     - API compatibility layers
     - Performance optimization tips
     - Troubleshooting common issues
     - Security considerations
  3. Updated `CLAUDE.md` to include the new documentation
  4. Created this `PROMPT_HISTORY.md` file
  5. Preparing to commit and push changes to GitHub

### Technical Details:
- Discovered Claude Code supports LLM gateways via `ANTHROPIC_BASE_URL` environment variable
- Learned about authentication options including static keys and dynamic token helpers
- Found support for corporate proxies via `HTTPS_PROXY` with SSL certificate handling
- Documented multiple provider endpoints (Anthropic, Bedrock, Vertex AI)