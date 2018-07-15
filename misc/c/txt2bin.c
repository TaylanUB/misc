#include <stdio.h>
#define BUF_SIZE 9999

int main(int argc, char **argv)
{
    int c, i, j;
    char buf[BUF_SIZE];

    while ( (c=getchar()) != EOF ) {
        i=1;
        j=0;
        while (i<256) {
            if (c & i) {
                buf[j] = '1';
                c-=i;
            } else
                buf[j] = '0';
            ++j;
            i<<=1;
        }
        for (; j>=0; --j)
            putchar(buf[j]);
    }

    putchar('\n');

    return 0;
}
