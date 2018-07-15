#include <stdio.h>

#define RANDFILE "/dev/urandom"
#define MIN 7
#define MAX 13
#define BANFOR 2

char *chars = "sdfjk";
int charcount[sizeof chars / sizeof *chars - sizeof *chars] = { 0 };

int getpos(char *s, char c)
{
    char *p;
    for (p=s; *p; ++p)
        if ( *p == c )
            return p-s;
    return -1;
}

int main(int argc, char **argv)
{
    int c;
    unsigned i = 0;
    unsigned max;
    int pos;

    FILE *randfile = fopen(RANDFILE, "r");

    max = MIN + (unsigned) getc(randfile) % ( MAX - MIN + 1 );

    while (( c = getc(randfile) % ( 'z' - 'a' + 1 ) + 'a' )) {
        if ( (pos = getpos(chars, c)) == -1 || ( charcount[pos] && i - charcount[pos] < BANFOR ) )
            continue;
        charcount[pos] = ++i;
        putchar(c);
        if ( i == max ) {
            putchar('\n');
            return 0;
        }
    }

    return 1;
}
