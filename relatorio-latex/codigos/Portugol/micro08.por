programa
{
  funcao inicio ()
  {
    inteiro numero
    numero = 1
    enquanto ( numero != 0 )
    {
      escreva ( "Digite um numero: " )
      leia ( numero )
      se ( numero > 10 )
      {
        escreva( "O numero ", numero, " eh maior que 10\n" )
      }
      senao
      {
        escreva( "O numero ", numero, " eh menor que 10\n" )
      }
    }
  }
}
