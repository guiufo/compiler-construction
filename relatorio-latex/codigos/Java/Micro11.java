package com.hello.android.hello;

import java.util.Scanner;

public class Micro11 {
    public static void main(String[] args) {
        int numero, x;
        Scanner leitor = new Scanner(System.in);

        numero = 0;
        x = 0;

        System.out.println("Digite um número: ");
        numero = leitor.nextInt();

        x = verifica(numero);

        if (x == 1) {
            System.out.println("Número positivo.");
        }
        else {
            if (x == 0) {
                System.out.println("Zero.");
            }
            else {
                System.out.println("Número negativo.");
            }
        }
    }

    public static int verifica(int numero) {
        int res;
        res = 0;
        if (numero > 0) {
            res = 1;
        }
        else {
            if (numero < 0 ) {
                res = -1;
            }
            else {
                res = 0;
            }
        }
        return res;
    }

}
