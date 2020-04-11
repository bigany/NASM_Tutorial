#include <math.h>
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#define NUM_OF_SAMPLES 50000000

// NOTE: (sonictk) x64 asm implementation
extern double correlation_avx(const double x[], const double y[], int n);

double correlation_ref(const double x[], const double y[], int n);

// NOTE: (sonictk) Reference implementation
double correlation_ref(const double x[], const double y[], int n)
{
    double sumX = 0.0;
    double sumY = 0.0;
    double sumXX = 0.0;
    double sumYY = 0.0;
    double sumXY = 0.0;

    for (int i=0; i < n; ++i) {
        sumX += x[i];
        sumY += y[i];
        sumXX += x[i] * x[i];
        sumYY += y[i] * y[i];
        sumXY += x[i] * y[i];
    }

    double covXY = (n * sumXY) - (sumX * sumY);
    double varX = (n * sumXX) - (sumX * sumX);
    double varY = (n * sumYY) - (sumY * sumY);

    return covXY / sqrt(varX * varY);
}


int main(int argc, char *argv[])
{
    srand(1);

    double *xDataSet = (double*) malloc(NUM_OF_SAMPLES*sizeof(double));
    double *yDataSet = (double*) malloc(NUM_OF_SAMPLES*sizeof(double));

    for (int i=0; i < NUM_OF_SAMPLES; ++i) {
        int xBaseVal = rand();
        int yBaseVal = rand();
        xDataSet[i] = (double)xBaseVal;
        yDataSet[i] = (double)yBaseVal;
    }

    LARGE_INTEGER startTimerValue;
    LARGE_INTEGER endTimerValue;
    LARGE_INTEGER timerFreq;

    QueryPerformanceFrequency(&timerFreq);
    QueryPerformanceCounter(&startTimerValue);

    double result = correlation_avx(xDataSet, yDataSet, NUM_OF_SAMPLES);

    QueryPerformanceCounter(&endTimerValue);

    double deltaTime = (double)(endTimerValue.QuadPart - startTimerValue.QuadPart * 1.0) / (double)timerFreq.QuadPart;

    //double result_ref = correlation_ref(xDataSet, yDataSet, NUM_OF_SAMPLES);
    printf("Time taken is: %f\nThe correlation is: %f\n", deltaTime, result);

    free(xDataSet);
    free(yDataSet);
    return 0;
}