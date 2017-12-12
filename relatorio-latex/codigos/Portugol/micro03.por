programa
{
  funcao inicio ()
  {
    inteiro numero
    escreva ( "Digite um numero: " )
    leia ( numero )

    se ( numero >= 100)
    {
      se ( numero <= 200 )
      {
        escreva ( "O numero esta no intervalo entre 100 e 200" )
      }
      senao
      {
        escreva ( "O numero nao esta no intervalo entre 100 e 200" )
      }
    }
    senao
    {
      escreva ( "O numero nao esta no intervalo entre 100 e 200" )
    }
  }
}
