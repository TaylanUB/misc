#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int isnum(char *str)
{
    int i;
    for (i=0; str[i]!='\0'; ++i)
        if ( ! isdigit(str[i]) ) return 0;
    return 1;
}

int fibo(int s1, int s2, int max)
{
    switch (max) {
        case 0: return 0;
        case 1: return s1;
        case 2: return s2;
        default: return fibo(s2, s1+s2, max-1);
    }
}

int main(int argc, char **argv)
{
    int s1, s2, max;

    switch (argc-1) {

    case 0:

        return 1;
        break;

    case 1:

        if ( ! isnum(argv[1]) ) return 1;

        s1=0;
        s2=1;
        max = atoi(argv[1]);

        break;

    case 2:

        if ( ! isnum(argv[1]) ) return 1;
        if ( ! isnum(argv[2]) ) return 1;

        s1=0;
        s2 = atoi(argv[1]);
        max = atoi(argv[2]);

        break;

    case 3:

        if ( ! isnum(argv[1]) ) return 1;
        if ( ! isnum(argv[2]) ) return 1;
        if ( ! isnum(argv[3]) ) return 1;

        s1 = atoi(argv[1]);
        s2 = atoi(argv[2]);
        max = atoi(argv[3]);

        break;

    default: return 1;

    }

    printf( "%d\n", fibo(s1,s2,max) );
    return 0;
}
