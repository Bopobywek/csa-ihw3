#include <stdlib.h>
#include <time.h>

extern double calculate(double x);

int64_t getTimeDiff(struct timespec ts1, struct timespec ts2) {
    int64_t ts1_ms = ts1.tv_sec * 1000 + ts1.tv_nsec / 1000000;
    int64_t ts2_ms = ts2.tv_sec * 1000 + ts2.tv_nsec / 1000000;

    return ts1_ms - ts2_ms;
}

int64_t measureTime(int64_t sample_size, double number, double *result) {
    struct timespec start;
    struct timespec end;
    int64_t elapsed = 0;

    for (int64_t i = 0; i < sample_size; ++i) {
        clock_gettime(CLOCK_MONOTONIC, &start);
        *result = calculate(number);
        clock_gettime(CLOCK_MONOTONIC, &end);
        elapsed += getTimeDiff(end, start);
    }

    return elapsed;
}
