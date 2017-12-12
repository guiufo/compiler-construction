programa
{
  funcao inicio ()
  {
    inteiro numero, x
    escreva ( "Digite um número: " )
    leia ( numero )
    x = verifica ( numero )
    se ( x == 1 )
    {
      escreva ( "Número positivo\n" )
    }
    senao
    {
      se ( x == 0)
      {
        escreva ( "Zero\n" )
      }
      senao
      {
        escreva ( "Número negativo\n" )
      }
    }
  }

  funcao inteiro verifica ( inteiro numero )
  {
    inteiro res
    se ( numero > 0 )
    {
      res = 1
    }
    senao
    {
      se ( numero < 0 )
      {
        res = -1
      }
      senao
      {
        res = 0
      }
    }
    retorne res
  }
}
