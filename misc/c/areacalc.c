#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct Wall Wall;

struct Wall {
  double len;
  double angle;
  Wall *next;
};

Wall *makeWall(double len, double angle, Wall *next)
{
  Wall *temp = malloc(sizeof(Wall));
  temp->len = len;
  temp->angle = angle * M_PI / 180.0;
  temp->next = next;
  return temp;
}

double getarea(Wall *root)
{
  Wall *curr = root;
  double totalarea = 0;
  double a, b, C, c_prev, A_prev, area;

  a = curr->len;
  b = curr->next->len;
  C = curr->angle;

  area = 0.5 * a * b * sin(C);

  totalarea += area;
  curr = curr->next;

  do {
    c_prev = sqrt( pow((sin(C)*b),2) + pow((a-cos(C)*b),2) );
    A_prev = asin( area * 2 / c_prev / b );
    if (curr->angle > M_PI)
      A_prev = M_PI - A_prev;

    a = c_prev;
    b = curr->next->len;
    C = curr->angle - A_prev;

    area = 0.5 * a * b * sin(C);

    totalarea += area;

    curr = curr->next;
  } while ( curr->next != root );

  return totalarea;
}

int main(int argc, char **argv)
{
  /*
    10                10
    ..........         ...........
    .      5 .   10    .         .
    10 .        ...........         .
    .                            .
    .                            .
    start2 -> ..............................
    ^
    start1

  */

  /* start1 */
  Wall *root1 = makeWall( 10, 90, NULL );
  root1->next = makeWall( 10, 90, NULL );
  root1->next->next = makeWall( 5, 270, NULL );
  root1->next->next->next = makeWall( 10, 270, NULL );
  root1->next->next->next->next = makeWall( 5, 90, NULL );
  root1->next->next->next->next->next = makeWall( 10, 90, NULL );
  root1->next->next->next->next->next->next = makeWall( 10, 90, NULL );
  root1->next->next->next->next->next->next->next = makeWall( 30, 90, root1 );

  /* start2 (using outer angles) */
  /* broken */
  Wall *root2 = makeWall( 30, 270, NULL );
  root2->next = makeWall( 10, 270, NULL );
  root2->next->next = makeWall( 10, 270, NULL );
  root2->next->next->next = makeWall( 5, 90, NULL );
  root2->next->next->next->next = makeWall( 10, 90, NULL );
  root2->next->next->next->next->next = makeWall( 5, 270, NULL );
  root2->next->next->next->next->next->next = makeWall( 10, 270, NULL );
  root2->next->next->next->next->next->next->next = makeWall( 10, 270, root2 );

  printf("%f\n%f\n", getarea(root1), getarea(root2));

  return 0;
}
