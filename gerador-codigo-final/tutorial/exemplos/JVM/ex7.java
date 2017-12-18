import java.util.Scanner;

class ex7 {
  static int a, b, soma;
  
  static int somador(int x, int y, int z){
    int r;
    int m;
    
    m = 1;
    r = m*(x + y + z);
    return r;
  }
  
  public static void main(String[] args) {
    a = 2;
    b = 3;
    soma = somador(a+1, b+2, 5);
    System.out.println(a);
    System.out.println(b);
    System.out.println(soma);
  }
}

/* Para ver o código JVM:
   0 - Pacotes necessários no Ubuntu 17.10
   
   sudo apt-get install mono-mcs mono-utils mono-devel
   
   1 - Compile e teste
   
   javac ex7.java
   java ex7
   
   2 - Descompile e guarde o código CIL:
   
   javap -c ex7.class > ex7.j
   
   3 - Para compilar o CIL 
   
   rm -f ex7.exe
   ilasm ex7.il
   mono ex7.exe
*/
