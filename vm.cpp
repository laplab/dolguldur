#include <cstdint>

struct State {
    int32_t current = 0;
    uint8_t stack[100];
};

extern "C" void pushConst(State* state, uint8_t constant) {
    state->stack[state->current++] = constant;
}

extern "C" void add(State* state) {
    uint8_t right = state->stack[state->current - 1];
    uint8_t left = state->stack[state->current - 2];
    state->current -= 2;
    state->stack[state->current++] = right + left;
}