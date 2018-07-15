#include <stdio.h>
#include <string.h>

int main(int argc, char** argv)
{
    int i, c, c2, c3;

    if (argc!=2) goto usage;

    if ( strcmp(argv[1],"e") == 0 ) {

        while ( (c=getchar()) != EOF )

            if (
                (c>='A'&&c<='Z') ||
                (c>='a'&&c<='z') ||
                c=='-' ||
                c=='_' ||
                c=='.' ||
                c=='~'
               )
                putchar(c);

            else
                printf("%%%02x",c);

    }
    else if ( strcmp(argv[1],"d") == 0 ) {

        while ( (c=getchar()) != EOF )

            if ( c=='%' ) {

                c3 = 0;
                for (i=0; i<2; ++i) {
                    if ( (c2 = getchar()) == EOF ) goto badinput;
                    else if ( c2 >= '0' && c2 <= '9' ) c3 +=  0 + c2 - '0';
                    else if ( c2 >= 'a' && c2 <= 'f' ) c3 += 10 + c2 - 'a';
                    else if ( c2 >= 'A' && c2 <= 'F' ) c3 += 10 + c2 - 'A';
                    else goto badinput;
                    if (i==0) c3 <<= 4;
                }

                putchar(c3);

            } else putchar(c);

    }
    else goto usage;

    return 0;

    usage:
    fprintf(stderr, "usage:  %s e < raw > encoded\n", argv[0]);
    fprintf(stderr, "        %s d < encoded > raw\n", argv[0]);
    return 1;

    badinput:
    fprintf(stderr, "%s: bad input!\n", argv[0]);
    return 1;
}
