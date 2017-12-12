package com.hello.android.hello;

import java.util.Scanner;

public class Micro06 {
    public static void main(String[] args) {
        int n;
        n = 0;
        Scanner leitor = new Scanner(System.in);

        System.out.println( "Digite um número de 1 a 5: " );

        switch (n){
            case 1:
                System.out.println( "Um");
                break;
            case 2:
                System.out.println( "Dois");
                break;
            case 3:
                System.out.println( "Três");
                break;
            case 4:
                System.out.println( "Quatro");
                break;
            case 5:
                System.out.println( "Cinco");
                break;
            default:
                System.out.println( "Número inválido.");
                break;
        }
    }
}
