#include <stdio.h>

int a, b, soma;
  
int somador(int x, int y, int z){
    int r;
    int m;
    r = 3;
    m = 1;
    r = m*(x + y + z);
    return r;
  }
  
void main() {
    a = 2;
    b = 3;
    soma = somador(a+1, b+2, 5);
    printf("%d\n",a);
    printf("%d\n",b);
    printf("%d\n",soma);
}

/* Para ver o código CIL:
   0 - Pacotes necessários no Ubuntu 17.10
   
   sudo apt-get install mono-mcs mono-utils mono-devel
   
   1 - Compile e teste
   
   gcc ex7.c -o ex7.exe
   ./ex7.exe
   
   2 - Gere o código assembler do GNU Asm:
   
   gcc -O0 -fno-asynchronous-unwind-tables -fno-dwarf2-cfi-asm -S ex7.c
   cat ex7.s
   
   3 - Para compilar o CIL 
   
   rm -f ex7.exe
   ilasm ex7.il
   mono ex7.exe
*/
