#include <iostream>

#include "vm.h"

int main() {
    State state;
    pushConst(&state, 1);
    pushConst(&state, 2);
    add(&state);

    std::cout << int(state.stack[0]) << std::endl;
    return 0;
}