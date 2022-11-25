#include <stdlib.h>

int validateNumber(double number) {
    return number <= 0.999 && number >= -1.0;
}

int max(int a, int b) {
    if (a > b) {
        return a;
    }

    return b;
}

double min(double a, double b) {
    if (a > b) {
        return b;
    }

    return a;
}

double getRandomDouble() {
    // 0 <= random < RAND_MAX
    int random = max(rand(), 1) - 1;
    return min((double)random / RAND_MAX * 2.0 - 1.0, 0.999);
}
