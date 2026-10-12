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

# Create a fake HOME so make doesn't touch real dotfiles
FAKE_HOME="$(mktemp -d)"
trap 'rm -rf "$FAKE_HOME"' EXIT

mkdir -p "$FAKE_HOME/dotfiles"
tar -c -C "$REPO_DIR" \
  --exclude=build-src --exclude=downloads . |
  tar -x -C "$FAKE_HOME/dotfiles"

# vim-plugins and build are left out: they need vim and a toolchain, and the
# point here is the install and fetch steps.
run_make() {
  HOME="$FAKE_HOME" make -C "$FAKE_HOME/dotfiles" "$@" > /dev/null 2>&1
}

echo "=== Run 1: Smoke test ==="
run_make install deps

echo ""
echo "--- Checking results ---"
for f in $(make -s -C "$FAKE_HOME/dotfiles" print-DOTFILES); do
  check "symlink: .$f" test -L "$FAKE_HOME/.$f"
done
check "symlink: Code/User/settings.json" test -L "$FAKE_HOME/.config/Code/User/settings.json"
check "file: .bashrc (copied)"        test -f "$FAKE_HOME/.bashrc"
check "file: .git-prompt.sh"          test -f "$FAKE_HOME/.git-prompt.sh"
check "file: .git-completion.bash"    test -f "$FAKE_HOME/.git-completion.bash"
check "file: .vim/autoload/plug.vim"  test -f "$FAKE_HOME/.vim/autoload/plug.vim"
check "dir: .fzf"                     test -d "$FAKE_HOME/.fzf"
check "dir: .tmux/plugins/tpm"        test -d "$FAKE_HOME/.tmux/plugins/tpm"

# The configs source fzf themselves, so its installer must not write to the
# shell rc files, which are symlinks back into the repo.
check "fzf left config/zshrc alone" \
  git -C "$FAKE_HOME/dotfiles" diff --quiet -- config/zshrc

echo ""
echo "=== Run 2: Idempotency test ==="
run_make install deps

echo ""
echo "--- Checking results ---"
check "idempotent: .vimrc is symlink"      test -L "$FAKE_HOME/.vimrc"
check "idempotent: .tmux.conf is symlink"  test -L "$FAKE_HOME/.tmux.conf"
check "idempotent: .git-prompt.sh exists"  test -f "$FAKE_HOME/.git-prompt.sh"
check "idempotent: .fzf dir exists"        test -d "$FAKE_HOME/.fzf"
check "idempotent: .tmux/plugins/tpm"      test -d "$FAKE_HOME/.tmux/plugins/tpm"
check "idempotent: no .zshrc.old pileup"   test -z "$(find "$FAKE_HOME" -maxdepth 1 -name '.zshrc.old.*' -print -quit)"

echo ""
echo "=== Run 3: Backup test ==="
# A pre-existing regular file must be preserved, even when it is newer than
# the config it replaces.
rm -f "$FAKE_HOME/.zshrc"
echo "pre-existing" > "$FAKE_HOME/.zshrc"
run_make install

echo ""
echo "--- Checking results ---"
backup="$(find "$FAKE_HOME" -maxdepth 1 -name '.zshrc.old.*' -print -quit)"
check "backup: .zshrc is a symlink again"  test -L "$FAKE_HOME/.zshrc"
check "backup: .zshrc.old.* created"       test -n "$backup"
check "backup: original contents kept"     grep -q "pre-existing" "$backup"

echo ""
echo "=== Results: $passed passed, $failed failed ==="
if [ "$failed" -gt 0 ]; then
  exit 1
fi
echo "=== All tests passed ==="
