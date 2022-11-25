#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

extern double calculate(double x);
extern int validateNumber(double number);
extern double getRandomDouble();
extern int readDouble(FILE *stream, double *result);
extern int printDouble(FILE *stream, double number);
extern int64_t measureTime(int64_t sample_size, double number, double *result);

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
