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

## Session 2 - Repository Reorganization (2025-11-16)

### Request: Reorganize repository structure

User requested a complete reorganization of the repository to:
- Create a comprehensive resource for AI agent setup and configuration
- Store lessons learned and best practices
- Keep top level clean with hierarchical tool organization
- Move existing content (whisper, dictation, voice-mode, Local_LLM) into nested subfolders
- Create interactive top-level menu for tool selection and installation

### Actions Taken:

1. **Created New Directory Structure**
   - `tools/` - Main tools directory with categorized subdirectories
     - `speech/whisper/` - OpenAI Whisper
     - `speech/voice-mode/` - Voice Mode for Claude Code
     - `speech/dictation/` - General dictation setup
     - `llm/local-deployment/` - Local LLM deployment guides
     - `llm/claude-code/` - Claude Code integration
     - `productivity/` - Future productivity tools
   - `docs/` - Documentation directory
     - `best-practices.md` - Lessons learned and recommendations
     - `troubleshooting.md` - Common issues and solutions
   - `config/` - Configuration directory
     - `examples/` - Working configuration examples
     - `templates/` - Customizable templates

2. **Created Interactive Setup Script**
   - `setup.sh` - Main entry point with menu-driven interface
   - Supports both interactive and command-line modes
   - Color-coded terminal UI with nested menus
   - Direct access to documentation and installation scripts
   - Categories: Speech, LLM, Productivity, Docs, Config

3. **Reorganized Existing Content**
   - Moved `whisper.md` → `tools/speech/whisper/README.md`
   - Moved `dictation.md` → `tools/speech/dictation/README.md`
   - Moved `install.sh` → `tools/speech/voice-mode/install.sh`
   - Moved `Local_LLM.md` → `tools/llm/local-deployment/README.md`

4. **Created New Documentation**
   - **Top-level README.md**: Comprehensive overview with quick start, structure diagram, tool table
   - **tools/README.md**: Overview of all tool categories
   - **tools/speech/README.md**: Speech tools overview and comparison
   - **tools/speech/voice-mode/README.md**: Detailed Voice Mode documentation
   - **tools/llm/README.md**: LLM tools overview with architecture patterns
   - **tools/productivity/README.md**: Placeholder for future tools
   - **docs/best-practices.md**: Comprehensive best practices covering:
     - General principles (security, documentation)
     - Speech & dictation recommendations
     - LLM deployment strategies
     - Claude Code integration tips
     - Security & privacy guidelines
     - Common pitfalls to avoid
     - Maintenance schedules
     - Performance benchmarking
   - **docs/troubleshooting.md**: Detailed troubleshooting guide covering:
     - Audio & speech recognition issues
     - Voice Mode problems
     - LLM deployment errors
     - Claude Code integration issues
     - WSL2-specific problems
     - Network & connectivity
     - Performance optimization

5. **Created Configuration Examples**
   - `config/examples/ollama-with-claude.sh` - Ollama setup script
   - `config/examples/voice-mode-mcp.json` - Voice Mode MCP configuration
   - `config/templates/bashrc-ai-setup.sh` - Environment variables template
   - `config/README.md` - Configuration guide

6. **Updated Project Documentation**
   - **CLAUDE.md**: Completely rewritten to reflect new structure
     - Repository overview and structure
     - Common commands for all tools
     - Key file locations
     - Development notes and conventions
     - Architecture patterns
     - Git workflow
   - **PROMPT_HISTORY.md**: Added this session

### Technical Decisions:

1. **Hierarchical Organization**
   - Minimum 2-level nesting (tools/{category}/{tool}/)
   - Category grouping: speech, llm, productivity
   - Self-contained tool directories with README and scripts

2. **Documentation Strategy**
   - Top-level: Quick start and navigation
   - Category level: Overview and tool comparison
   - Tool level: Detailed setup and usage
   - Shared concerns: Cross-cutting docs in docs/

3. **Setup Script Design**
   - Color-coded terminal UI for better UX
   - Nested menus matching directory structure
   - Support for both interactive and CLI modes
   - Direct access to docs via `less`
   - Integration with tool installers

4. **Configuration Management**
   - Examples: Ready-to-use configurations
   - Templates: Starting points for customization
   - Separation of concerns: env vars, MCP configs, etc.

### File Statistics:
- Created: 15+ new documentation files
- Created: 3 configuration example/template files
- Created: 1 interactive setup script
- Moved: 4 existing files to new locations
- Updated: 2 project files (CLAUDE.md, PROMPT_HISTORY.md)

### Benefits of New Structure:
- Clean top-level with only essential files
- Easy navigation via interactive menu
- Scalable structure for adding new tools
- Comprehensive documentation for users
- Clear separation between tools, docs, and configs
- Self-contained tool directories
- Best practices and troubleshooting centralized

### Next Steps:
- Commit and push all changes to GitHub
- Test setup.sh menu system
- Add more tool-specific setup scripts as needed
- Expand productivity tools section
- Create video tutorials (future)