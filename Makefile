# Install dotfiles and build terminal tools from source.
#
# Installing and building are separate: `make` sets up configs and their
# dependencies, `make build` compiles tools into $(PREFIX). See
# notes/building-libraries.md for building tmux's and vim's libraries from
# source when distro packages are unavailable.

PREFIX ?= $(HOME)/.local
JOBS ?= $(shell nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 1)

# Build at full width by default, while letting an explicit -j win.
ifeq ($(filter -j%,$(MAKEFLAGS)),)
MAKEFLAGS += -j$(JOBS)
endif

CONFIG := config
BUILD_DIR := build-src
DL := downloads

TOOLS := tmux vim tmux-mem-cpu-load

TMUX_VER := 3.3a
TMUX_TAR := $(DL)/tmux-$(TMUX_VER).tar.gz

# Extra configure flags, for picking up hand-built libraries:
#   make vim VIM_CONFIGURE_FLAGS='--with-tlib=ncursesw LIBS=-ltinfo'
TMUX_CONFIGURE_FLAGS ?=
VIM_CONFIGURE_FLAGS ?=

DOTFILES := \
  aspell.en.prepl \
  aspell.en.pws \
  claude/CLAUDE.md \
  claude/settings.json \
  gitconfig \
  gvimrc \
  shrc \
  ssh-agent.bash \
  tmux.conf \
  vimrc \
  zshrc

DEPS := \
  $(HOME)/.git-prompt.sh \
  $(HOME)/.git-completion.bash \
  $(HOME)/.vim/autoload/plug.vim \
  $(HOME)/.fzf.bash \
  $(HOME)/.tmux/plugins/tpm

ifeq ($(shell uname),Darwin)
VSCODE_DIR := $(HOME)/Library/Application Support/Code/User
else
VSCODE_DIR := $(HOME)/.config/Code/User
endif

.PHONY: all install deps vim-plugins build $(TOOLS) test clean distclean help

all: install deps vim-plugins ## Install configs, dependencies and vim plugins

# A phony loop rather than one target per link: make would compare timestamps
# and so skip a pre-existing regular file that happened to be newer than the
# config replacing it, leaving it neither backed up nor linked.
install: ## Symlink configs into ~, no network access
	@set -e; \
	 link() { \
	   mkdir -p "$$(dirname "$$2")"; \
	   if [ -f "$$2" ] && [ ! -L "$$2" ]; then \
	     echo "Backing up $$2"; \
	     mv "$$2" "$$2.old.$$(date +%Y%m%d%H%M%S)"; \
	   else \
	     rm -f "$$2"; \
	   fi; \
	   echo "Linking $$2"; \
	   ln -s "$$1" "$$2"; \
	 }; \
	 for f in $(DOTFILES); do \
	   link "$(CURDIR)/$(CONFIG)/$$f" "$(HOME)/.$$f"; \
	 done; \
	 link "$(CURDIR)/$(CONFIG)/vscode/settings.json" "$(VSCODE_DIR)/settings.json"
	@# bashrc is copied rather than symlinked, and keeps its own backup.
	@if [ -f "$(HOME)/.bashrc" ] && [ ! -f "$(HOME)/.bashrc-original" ]; then \
	  cp "$(HOME)/.bashrc" "$(HOME)/.bashrc-original"; \
	fi
	@echo "Copying ~/.bashrc"
	@cp "$(CONFIG)/bashrc" "$(HOME)/.bashrc"

deps: $(DEPS) ## Fetch git, vim, fzf and tmux dependencies

$(HOME)/.git-prompt.sh:
	curl -fsSLo $@ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

$(HOME)/.git-completion.bash:
	curl -fsSLo $@ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

$(HOME)/.vim/autoload/plug.vim:
	curl -fsSLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

$(HOME)/.fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git $@

# zshrc and bashrc source fzf themselves, so the installer must leave the shell
# rc files alone: they are symlinks back into this repo.
$(HOME)/.fzf.bash: $(HOME)/.fzf
	$(HOME)/.fzf/install --completion --key-bindings --no-update-rc

$(HOME)/.tmux/plugins/tpm:
	git clone --depth 1 https://github.com/tmux-plugins/tpm $@

vim-plugins: $(HOME)/.vim/plugged ## Install vim plugins via Vim-Plug

# Editing the plugin list is what should trigger a reinstall.
$(HOME)/.vim/plugged: $(CONFIG)/vimrc $(HOME)/.vim/autoload/plug.vim | install
	vim -c "PlugInstall|qall"
	@test -d $@ || { echo "ERROR: Vim-Plug did not create $@" >&2; exit 1; }
	@touch $@

build: $(TOOLS) ## Build all tools into PREFIX (or one, e.g. `make vim`)

# The installed binary is the target, so PREFIX is honoured and deleting a
# binary is enough to rebuild it.
$(TOOLS): %: $(PREFIX)/bin/%

# Build and install an unpacked source tree under $(BUILD_DIR).
build_install = $(MAKE) -C $(BUILD_DIR)/$(1) && $(MAKE) -C $(BUILD_DIR)/$(1) install

$(DL) $(BUILD_DIR):
	mkdir -p $@

$(TMUX_TAR): | $(DL)
	curl -fsSLo $@ https://github.com/tmux/tmux/releases/download/$(TMUX_VER)/tmux-$(TMUX_VER).tar.gz

$(PREFIX)/bin/tmux: | $(TMUX_TAR) $(BUILD_DIR)
	rm -rf $(BUILD_DIR)/tmux-$(TMUX_VER)
	tar -xf $(TMUX_TAR) -C $(BUILD_DIR)
	cd $(BUILD_DIR)/tmux-$(TMUX_VER) && \
	  ./configure --prefix=$(PREFIX) $(TMUX_CONFIGURE_FLAGS)
	$(call build_install,tmux-$(TMUX_VER))

$(PREFIX)/bin/vim: | $(BUILD_DIR)
	rm -rf $(BUILD_DIR)/vim
	git clone --depth 1 https://github.com/vim/vim.git $(BUILD_DIR)/vim
	cd $(BUILD_DIR)/vim && \
	  ./configure --prefix=$(PREFIX) \
	    --with-features=huge \
	    --enable-terminal \
	    --enable-python3interp \
	    --disable-gui \
	    --without-x $(VIM_CONFIGURE_FLAGS)
	$(call build_install,vim)

$(PREFIX)/bin/tmux-mem-cpu-load: | $(BUILD_DIR)
	command -v cmake >/dev/null 2>&1 || { echo "ERROR: cmake is required" >&2; exit 1; }
	rm -rf $(BUILD_DIR)/tmux-mem-cpu-load
	git clone --depth 1 https://github.com/thewtex/tmux-mem-cpu-load.git $(BUILD_DIR)/tmux-mem-cpu-load
	cd $(BUILD_DIR)/tmux-mem-cpu-load && \
	  cmake -DCMAKE_INSTALL_PREFIX=$(PREFIX) .
	$(call build_install,tmux-mem-cpu-load)

test: ## Run the install and fetch steps against a temporary HOME
	bash test-setup.sh

clean: ## Remove build trees
	rm -rf $(BUILD_DIR)

distclean: clean ## Also remove downloaded tarballs
	rm -rf $(DL)

help: ## List targets
	@awk -F':.*##' '/^[a-z][a-z-]*:.*##/ { printf "  %-20s %s\n", $$1, $$2 }' \
	  $(MAKEFILE_LIST)

# Report a variable's value, e.g. `make print-DOTFILES`, so the test harness
# need not restate the list.
print-%:
	@echo $($*)
