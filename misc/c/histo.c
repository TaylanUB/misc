#include <stdio.h>
#include <stdlib.h>

#define IN  1
#define OUT 0

int main(int argc, char **argv)
{
    int c;
    int state = OUT;
    size_t wcsize = sizeof(int);
    int *wc = malloc(wcsize);
    int line = 0, highest = 0;
    int i, j;

    wc[line] = 0;
    while ((c = getchar()) != EOF) switch (c) {

        case ' ':
        case '\t':
            state = OUT;
            break;

        case '\n':
            if (wc[line] > highest) highest = wc[line];
            ++line;
            wcsize += sizeof(*wc);
            wc = realloc(wc, wcsize);
            wc[line] = 0;
            state = OUT;
            break;

        default:
            if (state == OUT) ++wc[line];
            state = IN;

    }

    for (i=highest; i>0; --i) {
        for (j=0; j<line; ++j)
            if (wc[j]>=i) putchar('*'); else putchar(' ');
        putchar('\n');
    }

    free(wc);
    return 0;
}
