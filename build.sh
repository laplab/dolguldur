BASE='/usr/local/opt/llvm@12/bin'
CLANG="$BASE/clang++"
LLVM_CONFIG="$BASE/llvm-config"
$CLANG -g lib.cpp -O3 -shared -undefined dynamic_lookup -o liblib.so
$CLANG -g ./liblib.so main.cpp `$LLVM_CONFIG --cxxflags --ldflags --system-libs --libs core orcjit native` -O3 -o main
