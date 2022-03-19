#include <stdio.h>
#include "CoolAlgo.h"

int returnConst()
{
    printf("Returning %d!\n", CONST);
    return CONST;
}

void speak(char* word)
{
    printf("Speaking: %s\n", word);
}