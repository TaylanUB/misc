#include <stdio.h>

int main(int argc, char **argv)
{
    FILE *f1, *f2;
    int a, b;

    switch (argc) {
        case 1: return 1;

        case 2: f1 = stdin;
                if ((f2 = fopen(argv[1], "r")) == NULL) return 1;
                break;

        case 3: if ((f1 = fopen(argv[1], "r")) == NULL) return 1;
                if ((f2 = fopen(argv[2], "r")) == NULL) return 1;
                break;

        default: return 1;
    }

    while( (a = fgetc(f1)) != EOF && (b = fgetc(f2)) != EOF )
        if (a != b) return 1;

    fclose(f1); fclose(f2);

    return 0;
}
