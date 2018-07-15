#include <stdio.h>

int main(int argc, char **argv)
{
    int i;
    int c;
    int perms = 0;
    int stop = 0;

    i=0;
    while (1)
    {
        c = getchar();

        switch (i) {
        case 0:
            stop = (c == EOF);
            break;
        case 1:
        case 4:
        case 7:
            switch (c) {
            case '-':
                break;
            case 'r':
                perms += 4 * ( i==1 ? 0100 : ( i==4 ? 010 : 1 ) );
                break;
            default:
                goto error;
            }
            break;

        case 2:
        case 5:
        case 8:
            switch (c) {
            case '-':
                break;
            case 'w':
                perms += 2 * ( i==2 ? 0100 : ( i==5 ? 010 : 1 ) );
                break;
            default:
                goto error;
            }
            break;

        case 3:
        case 6:
            switch (c) {
            case '-':
                break;
            case 'x':
                perms += ( i==3 ? 0100 : 010 );
                break;
            case 's':
                perms += ( i==3 ? 0100 : 010 );
                perms += ( i==3 ? 4 : 2 ) * 01000;
                break;
            default:
                goto error;
            }
            break;

        case 9:
            switch (c) {
            case '-':
                break;
            case 'x':
                perms += 1;
                break;
            case 't':
                perms += 1;
                perms += 01000;
                break;
            default:
                goto error;
            }
            break;

        case 10:
            if (c != '\n') goto error;
            printf("%o\n",perms);
            i=0;
            perms=0;
            continue;
        }

        ++i;

        if (stop) break;

    }

    return 0;

    error:
    fprintf(stderr, "BAD INPUT\n");
    return 1;
}
