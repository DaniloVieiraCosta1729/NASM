#include <stdio.h>
#include <stdint.h>

int main(int argc, char const *argv[])
{
    float valor = 5.0f;
    uint32_t bits = *(uint32_t *)&valor;
    bits = bits ^ 0b10000000000000000000000000000000; // xor: (A and not B) or (not A and B)

    printf("%.1f \n", *(float *)&bits);

    return 0;
}
