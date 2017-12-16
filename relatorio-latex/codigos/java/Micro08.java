package com.hello.android.hello;

import java.util.Scanner;

public class Micro08 {
    public static void main(String[] args) {
        int numero;
        Scanner leitor = new Scanner(System.in);

        numero = 1;
        while(numero != 0) {
            System.out.println("Digite um número: ");
            numero = leitor.nextInt();
            if( numero > 10 )
            {
                System.out.println( "O numero " + numero + " eh maior que 10" );
            }
            else
            {
                System.out.println( "O numero " + numero + " eh menor que 10" );
            }
        }
    }
}
