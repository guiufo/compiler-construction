package com.hello.android.hello;

import java.util.Scanner;

public class Micro07 {
    public static void main(String[] args) {
        int programa, numero;
        String opc = new String();
        Scanner leitor = new Scanner(System.in);

        programa = 1;

        while (programa == 1) {
            System.out.println("Digite um número: ");
            numero = leitor.nextInt();

            if (numero > 0) {
                System.out.println("Positivo");
            }
            else {
                if (numero == 0) {
                    System.out.println("O numero eh igual a 0");
                }
                if (numero < 0) {
                    System.out.println("O numero eh negativo");
                }
            }

            System.out.println("Deseja finalizar? (S/N) ");
            opc = leitor.next();
            if (opc == "S") {
                programa = 0;
            }
        }
    }
}
