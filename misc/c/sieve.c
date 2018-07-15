#include <stdlib.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    long long min = atoll(argv[1]), max = atoll(argv[2]),
              *list = malloc(sizeof(long long)*max),
              i, cur, cur2, *p;

    if (argc!=3)
        return 1;

    if (min < 0 || max < min)
        return 1;

    for (i=0, cur=2; cur<=max; ++i, ++cur)
        *(list+i) = cur;
    *(list+i) = 1;

    while ((cur = *list++)-1)
        if (cur) {
            if (cur >= min)
                printf("%lld\n",cur);
            p = list;
            while ((cur2 = *p++)-1)
                if (cur2 % cur == 0)
                    *(p-1) = 0;
        }

    return 0;
}
