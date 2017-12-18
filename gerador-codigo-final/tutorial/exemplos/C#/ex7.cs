using System;

class ex7 {
  static int a, b, soma;
  
  static int somador(int x, int y, int z){
    int r;
    int m;
    
    m = 1;
    r = m*(x + y + z);
    return r;
  }
  
  static void Main() {
    a = 2;
    b = 3;
    soma = somador(a+1, b+2, 5);
    Console.WriteLine(a);
    Console.WriteLine(b);
    Console.WriteLine(soma);
  }
}

/* Para ver o código CIL:
   0 - Pacotes necessários no Ubuntu 17.10
   
   sudo apt-get install mono-mcs mono-utils mono-devel
   
   1 - Compile e teste
   
   mcs ex7.cs
   mono ex7.exe
   
   2 - Descompile e guarde o código CIL:
   
   monodis ex7.exe > ex7.il
   
   3 - Para compilar o CIL 
   
   rm -f ex7.exe
   ilasm ex7.il
   mono ex7.exe
*/
