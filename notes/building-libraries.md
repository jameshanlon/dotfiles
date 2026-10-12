# Building tmux and vim libraries from source

`make build` links tmux and vim against the distro's libraries. On a machine
where those packages are unavailable (an old distro, or no root), build them
into the same prefix first.

Use the same `PREFIX` the Makefile installs into:

```bash
export PREFIX="$HOME/.local"
export PATH="$PREFIX/bin:$PATH"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PREFIX/lib64/pkgconfig:$PKG_CONFIG_PATH"
export CPPFLAGS="-I$PREFIX/include $CPPFLAGS"
export LDFLAGS="-L$PREFIX/lib -Wl,-rpath,$PREFIX/lib $LDFLAGS"
```

Each tarball follows the same pattern: unpack, `./configure
--prefix="$PREFIX"`, `make -j$(nproc)`, `make install`.

| Library  | Version              | Source |
|----------|----------------------|--------|
| bison    | 3.8.2                | `https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.gz` |
| flex     | 2.6.4                | `https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz` |
| ncurses  | 6.4                  | `https://ftp.gnu.org/gnu/ncurses/ncurses-6.4.tar.gz` |
| libevent | 2.1.12-stable        | `https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz` |

ncurses and libevent need extra configure flags:

```bash
# ncurses
./configure --prefix="$PREFIX" --with-shared --without-debug --with-termlib \
  --enable-pc-files --with-pkg-config-libdir="$PREFIX/lib/pkgconfig"

# libevent
./configure --prefix="$PREFIX" --enable-shared
```

## Linking tmux and vim against them

`--with-termlib` splits terminfo out into its own `libtinfo`, so tmux and vim
have to be told about both halves. Pass that through `make build` rather than
configuring by hand, so the rest of the flags stay in one place:

```bash
make vim VIM_CONFIGURE_FLAGS='--with-tlib=ncursesw LIBS=-ltinfo'
```

tmux additionally needs its rpath to be a `DT_RPATH` rather than a
`DT_RUNPATH`, because a `DT_RUNPATH` does not apply to libraries pulled in
transitively — `libtinfo` via `libncursesw`. Without this the loader falls back
to a system `libtinfo` and the tmux server crashes on startup:

Note that a `VAR=value` argument *replaces* the exported variable rather than
appending to it, so `LDFLAGS` has to carry the `-L` and `-rpath` flags forward
or there is no rpath left for `--disable-new-dtags` to convert:

```bash
make tmux TMUX_CONFIGURE_FLAGS="--with-tlib=ncursesw LIBS=-ltinfo \
  LDFLAGS='$LDFLAGS -Wl,--disable-new-dtags'"
```

## ninja

Distro packages cover this (`ninja-build` on Debian, `ninja` on Homebrew). To
bootstrap it by hand:

```bash
git clone --depth 1 https://github.com/ninja-build/ninja.git
cd ninja && python3 configure.py --bootstrap
install -m 0755 ./ninja "$PREFIX/bin/ninja"
```
