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
