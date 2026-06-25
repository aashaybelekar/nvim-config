#!/usr/bin/env bash
set -euo pipefail

# Neovim configuration requirements installer
# Installs all system dependencies for this nvim config

BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()    { echo -e "${BOLD}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[OK]${NC}   $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $*"; }

# ── Detect OS ─────────────────────────────────────────────────────────────────
if [[ -f /etc/debian_version ]]; then
  OS="debian"
elif [[ "$(uname)" == "Darwin" ]]; then
  OS="macos"
else
  warn "Unsupported OS. This script targets Debian/Ubuntu and macOS."
  exit 1
fi

# ── System packages ───────────────────────────────────────────────────────────
info "Installing system packages..."

PACKAGES=(
  git
  make
  gcc
  curl
  unzip
  wget
  ripgrep    # telescope live_grep
  fd-find    # telescope find_files (binary is fdfind on Debian)
  python3
  python3-pip
  python3-venv
)

if [[ "$OS" == "debian" ]]; then
  sudo apt-get update -qq
  sudo apt-get install -y "${PACKAGES[@]}"
  # Debian installs fd as fdfind; create symlink if missing
  if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
    sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
    success "Created fd -> fdfind symlink"
  fi
  # Install Node.js via NodeSource to avoid apt conflicts with bundled nodejs/npm
  if ! command -v node &>/dev/null; then
    info "Installing Node.js via NodeSource..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
  else
    success "Node.js already installed: $(node --version)"
  fi
elif [[ "$OS" == "macos" ]]; then
  if ! command -v brew &>/dev/null; then
    warn "Homebrew not found. Install it from https://brew.sh then re-run."
    exit 1
  fi
  # macOS package names differ slightly
  brew install git make gcc curl unzip wget ripgrep fd python3 node
fi
success "System packages installed"

# ── Neovim ────────────────────────────────────────────────────────────────────
if ! command -v nvim &>/dev/null; then
  info "Installing Neovim (latest stable)..."
  if [[ "$OS" == "debian" ]]; then
    NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
    curl -fsSL "$NVIM_URL" -o /tmp/nvim.tar.gz
    sudo tar -C /opt -xzf /tmp/nvim.tar.gz
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    rm /tmp/nvim.tar.gz
  elif [[ "$OS" == "macos" ]]; then
    brew install neovim
  fi
  success "Neovim installed: $(nvim --version | head -1)"
else
  success "Neovim already installed: $(nvim --version | head -1)"
fi

# ── Go ────────────────────────────────────────────────────────────────────────
if ! command -v go &>/dev/null; then
  info "Installing Go..."
  GO_VERSION="1.23.4"
  if [[ "$OS" == "debian" ]]; then
    curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" -o /tmp/go.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz
    rm /tmp/go.tar.gz
    export PATH="$PATH:/usr/local/go/bin"
    # Persist to profile
    if ! grep -q '/usr/local/go/bin' ~/.bashrc 2>/dev/null; then
      echo 'export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"' >> ~/.bashrc
    fi
  elif [[ "$OS" == "macos" ]]; then
    brew install go
  fi
  success "Go installed: $(go version)"
else
  success "Go already installed: $(go version)"
fi

export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# ── Go tools (used by conform.nvim: goimports, gofmt) ────────────────────────
info "Installing Go tools..."
go install golang.org/x/tools/cmd/goimports@latest
success "goimports installed"
# gofmt ships with Go — no separate install needed

# ── npm global tools (conform.nvim formatters) ────────────────────────────────
info "Installing npm global tools..."
npm install -g --silent prettierd prettier
success "prettierd + prettier installed"

# ── Python tools ──────────────────────────────────────────────────────────────
info "Installing Python tools..."
pip3 install --quiet --upgrade pip
# ruff and pyright are managed by Mason inside Neovim, but install
# system-level ruff as a fallback for CLI use
pip3 install --quiet ruff
success "Python tools installed"

# ── Node version check (markdown-preview.nvim needs npm at build time) ────────
NODE_MAJOR=$(node --version | sed 's/v\([0-9]*\).*/\1/')
if [[ "$NODE_MAJOR" -lt 14 ]]; then
  warn "Node.js $NODE_MAJOR detected. markdown-preview.nvim requires Node >= 14."
fi

# ── Nerd Font reminder ────────────────────────────────────────────────────────
echo ""
warn "A Nerd Font is required for icons (nvim-web-devicons, lualine, neo-tree)."
warn "Download one from https://www.nerdfonts.com and set it in your terminal."

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
success "All requirements installed."
info "Next steps:"
echo "  1. Start nvim — lazy.nvim will auto-install all plugins on first launch"
echo "  2. Mason will auto-install LSPs: pyright, ruff, gopls, lua_ls, jsonls, yamlls, bashls"
echo "  3. Run :checkhealth to verify everything is working"
