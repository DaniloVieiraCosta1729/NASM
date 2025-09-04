// I'm writing this program to see how the gcc will use the registers xmm. 
#include <stdio.h>

struct xmmRegisters
{
    int x;
    char y;
    double z;
}xmm;
int main(int argc, char const *argv[])
{
    xmm.x = 1;
    xmm.y = 2;
    xmm.z = 3.14;
    printf("%0.10f \n", xmm.z);
    return 0;
}
