package com.hello.android.hello;

import java.util.Scanner;

public class Micro01 {
    public static void main(String[] args) {
        // write your code here
        double cel, far;

        Scanner leitor = new Scanner(System.in);
        System.out.println("Tabela de conversao: Celsius -> Fahrenheith");
        System.out.println("Digite temperatura em Celsius: ");

        cel = leitor.nextDouble();
        far = ((9 * cel) + 160) / 5;
    }
}
