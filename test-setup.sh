#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

passed=0
failed=0

check() {
  local desc="$1"; shift
  if "$@"; then
    echo "  PASS: $desc"
    passed=$((passed + 1))
  else
    echo "  FAIL: $desc"
    failed=$((failed + 1))
  fi
}

# Create a fake HOME so setup.sh doesn't touch real dotfiles
FAKE_HOME="$(mktemp -d)"
trap 'rm -rf "$FAKE_HOME"' EXIT

# setup.sh expects the repo at $HOME/dotfiles
cp -r "$REPO_DIR" "$FAKE_HOME/dotfiles"

run_setup() {
  HOME="$FAKE_HOME" SKIP_BUILD=1 \
    bash -c 'cd "$HOME/dotfiles" && bash setup.sh' > /dev/null 2>&1
}

echo "=== Run 1: Smoke test ==="
run_setup

echo ""
echo "--- Checking results ---"
check "symlink: .vimrc"               test -L "$FAKE_HOME/.vimrc"
check "symlink: .tmux.conf"           test -L "$FAKE_HOME/.tmux.conf"
check "symlink: .gitconfig"           test -L "$FAKE_HOME/.gitconfig"
check "symlink: .zshrc"               test -L "$FAKE_HOME/.zshrc"
check "symlink: .ssh-agent.bash"      test -L "$FAKE_HOME/.ssh-agent.bash"
check "symlink: .gvimrc"              test -L "$FAKE_HOME/.gvimrc"
check "symlink: .claude/settings.json" test -L "$FAKE_HOME/.claude/settings.json"
check "file: .bashrc (copied)"        test -f "$FAKE_HOME/.bashrc"
check "file: .git-prompt.sh"          test -f "$FAKE_HOME/.git-prompt.sh"
check "file: .git-completion.bash"    test -f "$FAKE_HOME/.git-completion.bash"
check "file: .vim/autoload/plug.vim"  test -f "$FAKE_HOME/.vim/autoload/plug.vim"
check "dir: .fzf"                     test -d "$FAKE_HOME/.fzf"
check "dir: .tmux/plugins/tpm"        test -d "$FAKE_HOME/.tmux/plugins/tpm"
check "dir: .tmux-mem-cpu-load"       test -d "$FAKE_HOME/.tmux-mem-cpu-load"
check "dir: vim-src"                  test -d "$FAKE_HOME/vim-src"

echo ""
echo "=== Run 2: Idempotency test ==="
run_setup

echo ""
echo "--- Checking results ---"
check "idempotent: .vimrc is symlink"      test -L "$FAKE_HOME/.vimrc"
check "idempotent: .tmux.conf is symlink"  test -L "$FAKE_HOME/.tmux.conf"
check "idempotent: .git-prompt.sh exists"  test -f "$FAKE_HOME/.git-prompt.sh"
check "idempotent: .fzf dir exists"        test -d "$FAKE_HOME/.fzf"
check "idempotent: .tmux/plugins/tpm"      test -d "$FAKE_HOME/.tmux/plugins/tpm"

echo ""
echo "=== Results: $passed passed, $failed failed ==="
if [ "$failed" -gt 0 ]; then
  exit 1
fi
echo "=== All tests passed ==="
