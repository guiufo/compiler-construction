programa
{
  funcao inicio ()
  {
    inteiro programa, numero
    caracter opc
    programa = 1

    enquanto ( programa == 1)
    {
      escreva ( "Digite um numero: " )
      leia ( numero )
      se ( numero > 0 )
      {
        escreva ( "Positivo\n" )
      }
      senao
      {
        se ( numero == 0 )
        {
          escreva ( "O numero eh igual a 0" )
        }
        se ( numero < 0 )
        {
          escreva ( "O numero eh negativo" )
        }
      }

      escreva ( "Deseja finalizar? (S/N) " )
      leia ( opc )
      se ( opc == 'S' )
      {
        programa = 0
      }
    }
  }
}
