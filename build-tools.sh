#!/usr/bin/env bash
set -euo pipefail

# Build from source: ninja, bison, flex, ncurses, libevent, tmux, vim
# Usage:
#   PREFIX=/some/path ./build-tools.sh
# Default PREFIX is $HOME/.local

: "${PREFIX:=$HOME/.local}"
: "${JOBS:=$(nproc 2>/dev/null || echo 1)}"
BUILD_DIR="${PWD}/build-src"
DL="${PWD}/downloads"

mkdir -p "$PREFIX" "$BUILD_DIR" "$DL"

BISON_VER="3.8.2"
FLEX_VER="2.6.4"
NCURSES_VER="6.4"
LIBEVENT_TAG="release-2.1.12-stable"
LIBEVENT_NAME="libevent-2.1.12-stable"
TMUX_VER="3.3a"

export PATH="${PREFIX}/bin:${PATH}"
export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig:${PREFIX}/lib64/pkgconfig:${PREFIX}/share/pkgconfig:${PKG_CONFIG_PATH:-}"
export CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS:-}"
export LDFLAGS="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib ${LDFLAGS:-}"

echo "Installing into: $PREFIX"
echo "Build dir:      $BUILD_DIR"
echo "Downloads dir:  $DL"
echo "Jobs:           $JOBS"
echo

# Download $url to $dest unless already present.
fetch() {
  local url="$1" dest="$2"
  [ -f "$dest" ] && return 0
  if command -v curl >/dev/null 2>&1; then
    curl -L --fail -o "$dest" "$url"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$dest" "$url"
  else
    echo "ERROR: curl or wget required" >&2
    exit 1
  fi
}

# build_tarball <label> <src-subdir> <url> [extra configure args...]
build_tarball() {
  local label="$1" dir="$2" url="$3"
  shift 3
  echo "=== Building $label ==="
  local tar="${DL}/$(basename "$url")"
  fetch "$url" "$tar"
  rm -rf "${BUILD_DIR:?}/${dir}"
  tar -xf "$tar" -C "$BUILD_DIR"
  (
    cd "${BUILD_DIR}/${dir}"
    ./configure --prefix="$PREFIX" "$@"
    make -j"$JOBS"
    make install
  )
  hash -r
  echo "$label installed to $PREFIX"
}

cd "$BUILD_DIR"

if command -v ninja >/dev/null 2>&1; then
  echo "ninja already in PATH -> $(command -v ninja)"
else
  echo "=== Building ninja from source ==="
  PY="$(command -v python3 || command -v python || true)"
  [ -n "$PY" ] || { echo "ERROR: Python is required to bootstrap ninja" >&2; exit 1; }
  rm -rf "${BUILD_DIR}/ninja"
  git clone --depth 1 https://github.com/ninja-build/ninja.git "${BUILD_DIR}/ninja"
  (
    cd "${BUILD_DIR}/ninja"
    "$PY" configure.py --bootstrap
    install -d "$PREFIX/bin"
    install -m 0755 ./ninja "$PREFIX/bin/ninja"
  )
  hash -r
  echo "ninja installed to $PREFIX/bin"
fi

build_tarball "bison ${BISON_VER}" "bison-${BISON_VER}" \
  "https://ftp.gnu.org/gnu/bison/bison-${BISON_VER}.tar.gz"

build_tarball "flex ${FLEX_VER}" "flex-${FLEX_VER}" \
  "https://github.com/westes/flex/releases/download/v${FLEX_VER}/flex-${FLEX_VER}.tar.gz"

build_tarball "ncurses ${NCURSES_VER}" "ncurses-${NCURSES_VER}" \
  "https://ftp.gnu.org/gnu/ncurses/ncurses-${NCURSES_VER}.tar.gz" \
  --with-shared --without-debug --with-termlib

build_tarball "libevent ${LIBEVENT_TAG}" "${LIBEVENT_NAME}" \
  "https://github.com/libevent/libevent/releases/download/${LIBEVENT_TAG}/${LIBEVENT_NAME}.tar.gz"

# ncurses was built with --with-termlib, which splits terminfo into libtinfo.
TLIB="ncurses"
if [ -e "${PREFIX}/lib/libncursesw.so" ] || [ -e "${PREFIX}/lib/libncursesw.a" ]; then
  TLIB="ncursesw"
fi
EXTRA_LIBS=""
if [ -e "${PREFIX}/lib/libtinfo.so" ] || [ -e "${PREFIX}/lib/libtinfo.a" ]; then
  EXTRA_LIBS="-ltinfo"
fi

build_tarball "tmux ${TMUX_VER}" "tmux-${TMUX_VER}" \
  "https://github.com/tmux/tmux/releases/download/${TMUX_VER}/tmux-${TMUX_VER}.tar.gz" \
  LIBS="$EXTRA_LIBS"

echo "=== Cloning and building vim (HEAD) ==="
rm -rf "${BUILD_DIR}/vim"
git clone --depth 1 https://github.com/vim/vim.git "${BUILD_DIR}/vim"
(
  cd "${BUILD_DIR}/vim"
  ./configure --prefix="$PREFIX" \
    --with-features=huge \
    --enable-terminal \
    --disable-gui \
    --without-x \
    --with-tlib="$TLIB" \
    LIBS="$EXTRA_LIBS"
  make -j"$JOBS"
  make install
)
hash -r
echo "vim installed to $PREFIX/bin"

echo
echo "All done. Add $PREFIX/bin to your PATH if not already:"
echo "  export PATH=\"$PREFIX/bin:\$PATH\""
echo "If binaries fail to run due to missing libraries:"
echo "  export LD_LIBRARY_PATH=\"$PREFIX/lib:\$LD_LIBRARY_PATH\""
echo
echo "Installed components:"
for b in ninja bison flex tmux vim; do
  printf "  %-8s -> %s\n" "$b" "$(command -v "$b" || echo 'not found')"
done
