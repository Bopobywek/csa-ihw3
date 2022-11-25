#include <stdio.h>

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
