package com.hello.android.hello;

import java.util.Scanner;

public class Micro03 {
    public static void main(String[] args) {
        int num;
        Scanner reader = new Scanner(System.in);

        System.out.println( "Digite um número: " );
        num = reader.nextInt();
        System.out.println( "Digite o segundo número: " );


        if ( num >= 100)
        {
            if ( num <= 200 )
            {
                 System.out.println( "O numero esta no intervalo entre 100 e 200" );
            }
            else
            {
                 System.out.println( "O numero nao esta no intervalo entre 100 e 200" );
            }
        }
        else
        {
             System.out.println( "O numero nao esta no intervalo entre 100 e 200" );
        }
    }
}
