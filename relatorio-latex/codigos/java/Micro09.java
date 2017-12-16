package com.hello.android.hello;

import java.util.Scanner;

public class Micro09 {
    public static void main(String[] args) {
        double preco, venda, novo_preco;
        preco = 0;
        venda = 0;
        novo_preco = 0;
        Scanner leitor = new Scanner(System.in);

        System.out.println( "Digite o preco: " );
        preco = leitor.nextDouble();
        System.out.println( "Digite a venda: " );
        venda = leitor.nextDouble();

        if( venda < 500 || preco < 30)
        {
            novo_preco = preco + 10/100 * preco;
        }
        else
        {
            if ( (venda >= 500 && venda < 1200) || (preco >= 30 && preco < 80) )
            {
                novo_preco = preco + 15/100 * preco;
            }
            else
            {
                if( venda >= 1200 || preco >= 80 )
                {
                    novo_preco = preco - 20/100 * preco;
                }
            }
        }

        System.out.println( "O novo preco eh " + novo_preco);
    }
}
