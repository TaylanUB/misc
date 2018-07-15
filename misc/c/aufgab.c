#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[])
{
    char a[] = { 20, 30, 35, 40, 41, 42, 45, 75, 85, 88, 115, 120 };
    double mid, var;
    unsigned int i;

    for (i=0; i<sizeof(a); ++i)
        mid += a[i];
    mid /= 12;
    for (i=0; i<sizeof(a); ++i)
        var += pow(a[i]-mid, 2);
    var /= 12;

    printf("Durchschnitt: %f, Varianz: %f, Standardabweichung: %f\n", mid, var, sqrt(var));

    return 0;
}
