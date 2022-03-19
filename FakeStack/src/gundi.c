#include <stdio.h>
#include "gundi.h"

void gundi(int n)
{
    for (int i = 0; i < n; i++)
    {
        printf("gundi");
        if (i != n-1)
        {
            printf(" ");
        }
    }
    puts("!");
}