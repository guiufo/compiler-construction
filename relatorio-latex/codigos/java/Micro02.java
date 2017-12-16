package com.hello.android.hello;

import java.util.Scanner;

public class Micro02 {
    public static void main(String[] args) {
        int num1, num2;
        Scanner reader = new Scanner(System.in);

        System.out.println( "Digite o primeiro número: " );
        num1 = reader.nextInt();
        System.out.println( "Digite o segundo número: " );
        num2 = reader.nextInt();

        if ( num1 > num2 )
        {
            System.out.println("O primeiro numero " + num1 + " eh maior que o segundo " + num2 );
        }
        else
        {
            System.out.println("O segundo numero " + num2 + " eh maior que o primeiro " + num1 );
        }
    }
}
