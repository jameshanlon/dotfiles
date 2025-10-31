## C++ development environment

CMake presets reference:
https://martin-fieber.de/blog/cmake-presets/#user-presets

Compile clang+tooling locally
``` bash
git clone --branch llvmorg-21.1.0 --depth 1 https://github.com/llvm/llvm-project.git
cd llvm-project
mkdir build
mkdir install
cd build
cmake -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PWD/../install -G Ninja ../llvm
ninja
ninja install
```
