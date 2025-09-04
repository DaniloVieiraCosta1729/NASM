#include <stdio.h>
#include <math.h>

int main(int argc, char const *argv[])
{
    float x;

    scanf("%f",&x);

    printf("O dobro eh: %.0f\nOTriplo eh: %.0f\nA raiz quadrada eh: %.5f", x*2, x*3, sqrt(x));

    return 0;

}
