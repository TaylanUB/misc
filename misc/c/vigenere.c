#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

typedef enum 
  {
    CODE,
    DECODE,
  }
  operation_t;

int main(int argc, char **argv)
{
  operation_t operation;

  FILE *datastream = stdin;
  FILE *keystream = fdopen(3, "r");

  size_t i;
  int c;
  char *key = malloc(1); key[0] = '\0';

  switch (argc) {
  case 1: return 1;

  case 2:
    if (strcmp(argv[1],"c")==0) operation = CODE;
    else if (strcmp(argv[1],"d")==0) operation = DECODE;
    else return 1;
    break;

  default: return 1;
  }

  i = 0;
  while ( (c = fgetc(keystream)) != EOF )
    {
      if ( 'A' <= c && c <= 'Z' )
        c -= 'A';
      else if ( 'a' <= c && c <= 'z' )
        c -= 'a';
      else
        c = 0;

      key = realloc(key, i+2);
      key[i] = c;
      key[i+1] = '\0';
      ++i;
    }
  fclose(keystream);

  i = 0;
  while ( (c = fgetc(datastream)) != EOF )
    {
      if ( 'A' <= c && c <= 'Z' ) /* make lowercase */
        c += 'a'-'A';

      if ( 'a' <= c && c <= 'z' )
        switch (operation) {
        case   CODE: c = (c-'a'+key[i]) % 26 + 'a'; break;
        case DECODE: c = (c-'a'-key[i]+26) % 26 + 'a'; break;
        default: return 1;
        }

      putchar(c);

      ++i; if (i==strlen(key)) i=0;
    }
  fclose(datastream);

  free(key);
  return 0;
}
