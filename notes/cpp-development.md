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

Example `CmakeUserPresets.json`:
``` json
{
  "version": 3,
  "configurePresets": [
    {
      "name": "macos-local-development",
      "displayName": "macOS local development",
      "generator": "Ninja",
      "inherits": [
        "macos-debug"
      ],
      "cacheVariables": {
        "CMAKE_PREFIX_PATH":  "/Users/jamie/llvm-project/install/bin",
        "CMAKE_BUILD_TYPE": "Debug",
        "BUILD_DOCS": "On",
        "USE_STATIC_ANALYZER": "clang-tidy"
      }
    }
]
}
```
