package com.hello.android.hello;

import java.util.Scanner;

public class Micro04 {
    public static void main(String[] args) {
        Scanner leitor = new Scanner(System.in);
        int x, num, intervalo;
        intervalo = 0;

        for ( x = 1; x <= 5; x++)
        {
            System.out.println( "Digite um numero: " );
            num = leitor.nextInt();
            if ( num >= 10 )
            {
                if( num <= 150 )
                {
                    intervalo = intervalo + 1;
                }
            }
        }

        System.out.println( "Ao total, foram digitados " + intervalo + " numeros no intervalo entre 10 e 150" );
    }
}
