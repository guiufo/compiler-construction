import java.util.Scanner;

public class Micro10 {
    public static void main(String[] args) {
        int numero, fat;
        numero = 0;
        fat = 0;
        Scanner leitor = new Scanner(System.in);
        System.out.println("Digite um numero: ");
        numero = leitor.nextInt();
        fat = fatorial(numero);
        System.out.println("O fatorial de " + numero + " e " + fat);

    }

    public static int fatorial(int numero) {
        if (numero <= 0) return 1;
        else return numero * fatorial (numero - 1);
    }
}
