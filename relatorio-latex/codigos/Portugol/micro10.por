programa
{
  funcao inicio ()
  {
    inteiro numero, fat
    escreva ( "Digite um numero: " )
    leia ( numero )
    fat = fatorial ( numero )
    escreva ( "O fatorial de ", numero, " eh ", fat, "\n" )
  }

  funcao inteiro fatorial ( inteiro numero )
  {
    se ( numero <= 0)
    {
      retorne 1
    }
    senao
    {
      retorne numero * fatorial ( numero - 1)
    }
  }
}
