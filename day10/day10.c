#include "stdio.h"
#include "stdlib.h"

#define LINE_SIZE 8
#define INPUT_SIZE 128

int compare(const void *a, const void *b) {
    int *x = (int *) a;
    int *y = (int *) b;
    return *x - *y;
}

int part1(int *input, int length) {
    int oneCnt = 0;
    int threeCnt = 0;

    for (int i = 1; i < length; i++) {
        int diff = input[i] - input[i-1];
        switch(diff) {
            case 1:
                oneCnt++;
                break;
            case 3:
                threeCnt++;
                break;
        }
    }
    return oneCnt * threeCnt;
}

long long part2(int *input, int length) {
    long long lookup[length];
    for (int i = 0; i < length; i++) {
        lookup[i] = 0;
    }
    lookup[0] = 1;

    for (int i = 1; i < length; i++) {
        for (int j = i - 1; j >= 0; j--) {
            if (input[i] - input[j] > 3) {
                break;
            }
            lookup[i] += lookup[j];
        }
    }
    return lookup[length - 1];
}

int main() {
    FILE *file;
    file = fopen("input.txt", "r");
    if (!file) {
        printf("Error reading file!\n");
        return 1;
    }

    int input[INPUT_SIZE];
    input[0] = 0;
    int length = 1;

    char line[LINE_SIZE];
    while (fgets(line, sizeof(line), file)) {
        input[length++] = atoi(line);
    }
    fclose(file);

    qsort(input, length, sizeof(int), compare);
    input[length++] = input[length - 1] + 3;
    
    printf("Solution 1: %d\n", part1(input, length));
    printf("Solution 2: %lld\n", part2(input, length));

    return 0;
}