#!/bin/bash
# AI Agent Setup & Configuration Tool
# Interactive menu for selecting and installing AI tools

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_header() {
  echo -e "\n${BOLD}${CYAN}=================================${NC}"
  echo -e "${BOLD}${CYAN}  AI Agent Setup & Configuration${NC}"
  echo -e "${BOLD}${CYAN}=================================${NC}\n"
}

print_info() {
  echo -e "${BLUE}ℹ ${NC}$1"
}

print_success() {
  echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
  echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
  echo -e "${RED}❌ $1${NC}"
}

show_main_menu() {
  clear
  print_header
  echo "Select a category:"
  echo ""
  echo "  1. Speech & Dictation Tools"
  echo "  2. LLM Tools"
  echo "  3. Productivity Tools"
  echo ""
  echo "  4. View Documentation"
  echo "  5. Configuration Examples"
  echo ""
  echo "  0. Exit"
  echo ""
  read -p "Enter your choice [0-5]: " choice

  case $choice in
    1) show_speech_menu ;;
    2) show_llm_menu ;;
    3) show_productivity_menu ;;
    4) show_docs_menu ;;
    5) show_config_menu ;;
    0) exit 0 ;;
    *)
      print_error "Invalid choice. Please try again."
      sleep 2
      show_main_menu
      ;;
  esac
}

show_speech_menu() {
  clear
  print_header
  echo -e "${BOLD}Speech & Dictation Tools${NC}\n"
  echo "  1. OpenAI Whisper - Local speech recognition"
  echo "  2. Voice Mode - Voice interface for Claude Code"
  echo "  3. General Dictation Setup"
  echo ""
  echo "  0. Back to main menu"
  echo ""
  read -p "Enter your choice [0-3]: " choice

  case $choice in
    1)
      print_info "Opening Whisper documentation..."
      less "$SCRIPT_DIR/tools/speech/whisper/README.md"
      echo ""
      read -p "Would you like to run the Whisper installation? (y/n): " install
      if [[ "$install" == "y" || "$install" == "Y" ]]; then
        if [ -f "$SCRIPT_DIR/tools/speech/whisper/install.sh" ]; then
          bash "$SCRIPT_DIR/tools/speech/whisper/install.sh"
        else
          print_warning "Installation script not found. Please follow the manual instructions in the README."
        fi
      fi
      read -p "Press Enter to continue..."
      show_speech_menu
      ;;
    2)
      print_info "Opening Voice Mode documentation..."
      if [ -f "$SCRIPT_DIR/tools/speech/voice-mode/README.md" ]; then
        less "$SCRIPT_DIR/tools/speech/voice-mode/README.md"
      fi
      echo ""
      read -p "Would you like to run the Voice Mode installation? (y/n): " install
      if [[ "$install" == "y" || "$install" == "Y" ]]; then
        if [ -f "$SCRIPT_DIR/tools/speech/voice-mode/install.sh" ]; then
          bash "$SCRIPT_DIR/tools/speech/voice-mode/install.sh"
        else
          print_error "Installation script not found."
        fi
      fi
      read -p "Press Enter to continue..."
      show_speech_menu
      ;;
    3)
      print_info "Opening Dictation Setup guide..."
      less "$SCRIPT_DIR/tools/speech/dictation/README.md"
      read -p "Press Enter to continue..."
      show_speech_menu
      ;;
    0) show_main_menu ;;
    *)
      print_error "Invalid choice. Please try again."
      sleep 2
      show_speech_menu
      ;;
  esac
}

show_llm_menu() {
  clear
  print_header
  echo -e "${BOLD}LLM Tools${NC}\n"
  echo "  1. Local LLM Deployment (Ollama/LocalAI/vLLM)"
  echo "  2. Claude Code Integration"
  echo "  3. Ollama Setup"
  echo "  4. LocalAI Setup"
  echo "  5. vLLM Setup"
  echo ""
  echo "  0. Back to main menu"
  echo ""
  read -p "Enter your choice [0-5]: " choice

  case $choice in
    1)
      print_info "Opening Local LLM Deployment guide..."
      less "$SCRIPT_DIR/tools/llm/local-deployment/README.md"
      read -p "Press Enter to continue..."
      show_llm_menu
      ;;
    2)
      print_info "Opening Claude Code Integration guide..."
      if [ -f "$SCRIPT_DIR/tools/llm/claude-code/README.md" ]; then
        less "$SCRIPT_DIR/tools/llm/claude-code/README.md"
      else
        print_warning "Claude Code guide not yet available."
      fi
      read -p "Press Enter to continue..."
      show_llm_menu
      ;;
    3)
      print_info "Opening Ollama setup guide..."
      if [ -f "$SCRIPT_DIR/tools/llm/local-deployment/ollama/README.md" ]; then
        less "$SCRIPT_DIR/tools/llm/local-deployment/ollama/README.md"
      else
        print_warning "Ollama guide not yet available. See Local LLM Deployment guide."
      fi
      read -p "Press Enter to continue..."
      show_llm_menu
      ;;
    4)
      print_info "Opening LocalAI setup guide..."
      if [ -f "$SCRIPT_DIR/tools/llm/local-deployment/localai/README.md" ]; then
        less "$SCRIPT_DIR/tools/llm/local-deployment/localai/README.md"
      else
        print_warning "LocalAI guide not yet available. See Local LLM Deployment guide."
      fi
      read -p "Press Enter to continue..."
      show_llm_menu
      ;;
    5)
      print_info "Opening vLLM setup guide..."
      if [ -f "$SCRIPT_DIR/tools/llm/local-deployment/vllm/README.md" ]; then
        less "$SCRIPT_DIR/tools/llm/local-deployment/vllm/README.md"
      else
        print_warning "vLLM guide not yet available. See Local LLM Deployment guide."
      fi
      read -p "Press Enter to continue..."
      show_llm_menu
      ;;
    0) show_main_menu ;;
    *)
      print_error "Invalid choice. Please try again."
      sleep 2
      show_llm_menu
      ;;
  esac
}

show_productivity_menu() {
  clear
  print_header
  echo -e "${BOLD}Productivity Tools${NC}\n"
  echo "  Coming soon!"
  echo ""
  echo "  This section will contain additional AI-powered productivity tools."
  echo ""
  read -p "Press Enter to return to main menu..."
  show_main_menu
}

show_docs_menu() {
  clear
  print_header
  echo -e "${BOLD}Documentation${NC}\n"
  echo "  1. Best Practices & Lessons Learned"
  echo "  2. Troubleshooting Guide"
  echo "  3. Repository Overview"
  echo ""
  echo "  0. Back to main menu"
  echo ""
  read -p "Enter your choice [0-3]: " choice

  case $choice in
    1)
      if [ -f "$SCRIPT_DIR/docs/best-practices.md" ]; then
        less "$SCRIPT_DIR/docs/best-practices.md"
      else
        print_warning "Best practices documentation not yet available."
      fi
      read -p "Press Enter to continue..."
      show_docs_menu
      ;;
    2)
      if [ -f "$SCRIPT_DIR/docs/troubleshooting.md" ]; then
        less "$SCRIPT_DIR/docs/troubleshooting.md"
      else
        print_warning "Troubleshooting guide not yet available."
      fi
      read -p "Press Enter to continue..."
      show_docs_menu
      ;;
    3)
      less "$SCRIPT_DIR/README.md"
      read -p "Press Enter to continue..."
      show_docs_menu
      ;;
    0) show_main_menu ;;
    *)
      print_error "Invalid choice. Please try again."
      sleep 2
      show_docs_menu
      ;;
  esac
}

show_config_menu() {
  clear
  print_header
  echo -e "${BOLD}Configuration Examples${NC}\n"

  if [ -d "$SCRIPT_DIR/config/examples" ]; then
    echo "Available configuration examples:"
    echo ""
    ls -1 "$SCRIPT_DIR/config/examples/" 2>/dev/null || echo "  No examples available yet."
    echo ""
  else
    print_warning "Configuration examples directory not found."
  fi

  if [ -d "$SCRIPT_DIR/config/templates" ]; then
    echo "Available configuration templates:"
    echo ""
    ls -1 "$SCRIPT_DIR/config/templates/" 2>/dev/null || echo "  No templates available yet."
    echo ""
  fi

  read -p "Press Enter to return to main menu..."
  show_main_menu
}

# Check if running with command-line arguments
if [ $# -gt 0 ]; then
  case "$1" in
    speech|--speech)
      show_speech_menu
      ;;
    llm|--llm)
      show_llm_menu
      ;;
    docs|--docs)
      show_docs_menu
      ;;
    *)
      echo "Usage: $0 [speech|llm|docs]"
      echo "  Or run without arguments for interactive menu"
      exit 1
      ;;
  esac
else
  # Interactive mode
  show_main_menu
fi
