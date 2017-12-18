#include <stdio.h>

int a, b, soma;

int gteste(int x){
  return x + 1;
}  

int fteste(int a, int b, int c, int d, int e, int f){
  int g,h,i,j,k,l,m;
  a = 1;
  b = 2;
  c = 3;
  d = 4;
  e = 5;
  f = 6;
  g = 11;
  h = 12;
  i = 13;
  j = 14;
  k = 15;
  l = 16;
  m = 17;
  
  return gteste(a+b+c+d+e+f+g+h+i+j+k+l+m);
}

int multiplicador(int m, int x){
  int z;
  z = 5;
  z = z * m * x;
  return z;
}
  
int somador(int x, int y, int z){
    int r;
    int m;
    m = 1;
    r = multiplicador(m, x + y + z);
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
   
   gcc -O0 -fno-asynchronous-unwind-tables -fno-dwarf2-cfi-asm -S ex9.c
   cat ex9.s
   
   3 - Para compilar o CIL 
   
   rm -f ex7.exe
   ilasm ex7.il
   mono ex7.exe
*/
