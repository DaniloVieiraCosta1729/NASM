/*
===================================================================================
Explora a ideia de X macro
===================================================================================
*/

#include <stdio.h>

#define SEQUENCIA_X \
    X(1) \
    X(2) \
    X(3) \
    X(4) 

int main(int argc, char const *argv[])
{
    #define X(a) printf("%d ^ 1 = %d\n", a, a);
        SEQUENCIA_X
    #undef X

    #define X(a) printf("%d ^ 2 = %d\n", a, a * a);
        SEQUENCIA_X
    #undef X

    return 0;
}
