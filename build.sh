BASE='/opt/mongodbtoolchain/v4/bin'
CLANG="$BASE/clang++"
LLVM_CONFIG="$BASE/llvm-config"
$CLANG -g main.cpp `$LLVM_CONFIG --cxxflags --ldflags --system-libs --libs core orcjit native` -O3 -o main
