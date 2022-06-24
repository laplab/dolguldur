BASE='/usr/local/opt/llvm@12/bin'
CLANG="$BASE/clang++"
LLVM_CONFIG="$BASE/llvm-config"
$CLANG -emit-llvm -S -O3 vm.cpp -o vm.ll
