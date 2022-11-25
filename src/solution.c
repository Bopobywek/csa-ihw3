#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

double EPS = 1E-7;

double calculate(double x) {
    double result = 0.0;
    double component = x;
    long long i = 2;
    while (component < -EPS || component > EPS) {
        result += component;
        component *= x;
        component *= (double)(i-1) / i;
        ++i;
    }

    return -result;
}

int readDouble(FILE *stream, double *result) {
    if (stream == NULL) {
        return 1;
    }

    fscanf(stream, "%lf", result);

    return 0;
}

int printDouble(FILE *stream, double number) {
    if (stream == NULL) {
        return 1;
    }

    fprintf(stream, "%lf\n", number);
    return 0;
}

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

int main(int argc, char *argv[]) {
    int opt;
    FILE *input = stdin;
    FILE *output = stdout;

    int random_flag = 0;
    int test_flag = 0;
    int seed = 42;
    int64_t sample_size = 0;

    while ((opt = getopt(argc, argv, "rt:s:i:o:")) != -1) {
        switch(opt) {
            // Генерация случайного набора
            case 'r':
                random_flag = 1;
                break;
                // Указание входного файла
            case 'i':
                input = fopen(optarg, "r");
                break;
                // Указание выходного файла
            case 'o':
                output = fopen(optarg, "w");
                break;
                // seed для рандома
            case 's':
                seed = atoi(optarg);
                break;
                // Тестирование на больших входных данных
                // некоторое количество раз для замера времени
            case 't':
                test_flag = 1;
                sample_size = atoll(optarg);
                break;
                // В случае ошибки
            case '?':
                return 0;
        }
    }

    srand(seed);

    double number;
    int status_code = 0;
    if (random_flag) {
        number = getRandomDouble();
        printf("%lf\n", number);
    } else if (input == stdin) {
        printf("Enter a real number in range [-1; 1):\n");
        status_code = readDouble(input, &number);
    } else {
        status_code = readDouble(input, &number);
    }

    if (status_code == 1) {
        printf("Error! The input file could not be read.\n");
        return 0;
    }

    status_code = validateNumber(number);
    if (status_code == 0) {
        printf("Error! The input number is not in the specified range.\n");
        return 0;
    }

    double result = calculate(number);

    if (test_flag) {
        printf("Running current test case %ld times...\n", sample_size);
        int64_t elapsed = measureTime(sample_size, number, &result);
        printf("Elapsed time: %ld ms\n", elapsed);
    }

    status_code = printDouble(output, result);
    if (status_code != 0) {
        printf("\nError! Output data cannot be written.\n");
    }

    return 0;
}
