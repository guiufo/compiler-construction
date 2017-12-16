package com.hello.android.hello;

import java.util.Scanner;

public class Micro05 {
    public static void main(String[] args) {
        int x, h, m;
        x = 0;
        h = 0;
        m = 0;
        Scanner leitor = new Scanner(System.in);
        String nome = new String();
        String sexo = new String();

        for ( x = 1; x <= 5; x++)
        {
            System.out.println( "Digite o nome: " );
            nome = leitor.next();
            System.out.println( "Homem(H) ou Mulher(M)?" );
            sexo = leitor.next();

            switch (sexo){
                case "H":
                    h = h + 1;
                    break;
                case "M":
                    m = m + 1;
                    break;
                default:
                    System.out.println( "Homem(H) ou Mulher(M)!" );
                    break;
            }
        }

        System.out.println( "Foram inseridos " + h + " homens");
        System.out.println( "Foram inseridos " + m + " mulheres");
    }
}
