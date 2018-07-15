#include <stdio.h>

void put(char c)
{
    switch (c) {

    case 'f': putchar('e'); break;
    case 'p': putchar('r'); break;
    case 'g': putchar('t'); break;
    case 'j': putchar('z'); break;
    case 'l': putchar('u'); break;
    case 'u': putchar('i'); break;
    case 'y': putchar('o'); break;
    case ';': putchar('p'); break;
    case 'r': putchar('s'); break;
    case 's': putchar('d'); break;
    case 't': putchar('f'); break;
    case 'd': putchar('g'); break;
    case 'n': putchar('j'); break;
    case 'e': putchar('k'); break;
    case 'i': putchar('l'); break;
    case 'o': printf("ş"); break;
    case 'k': putchar('n'); break;

    case 'F': putchar('E'); break;
    case 'P': putchar('R'); break;
    case 'G': putchar('T'); break;
    case 'J': putchar('Z'); break;
    case 'L': putchar('U'); break;
    case 'U': putchar('I'); break;
    case 'Y': putchar('O'); break;
    /* no uppercase for ';' */
    case 'R': putchar('S'); break;
    case 'S': putchar('D'); break;
    case 'T': putchar('F'); break;
    case 'D': putchar('G'); break;
    case 'N': putchar('J'); break;
    case 'E': putchar('K'); break;
    case 'I': putchar('L'); break;
    case 'O': printf("Ş"); break;
    case 'K': putchar('N'); break;

    default: putchar(c);

    }
}

int main(int argc, char **argv)
{
    int c;
    if (argc==1)
        while ((c=getchar())!=EOF)
            put(c);
    else
        for (c=1; c<argc; ++c) {
            while(*argv[c]) {
                put(*argv[c]);
                ++argv[c];
            }
            putchar(' ');
        }

    return 0;
}
