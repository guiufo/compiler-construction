programa
{
  funcao inicio ()
  {
    inteiro x, num, intervalo
    intervalo = 0

    para ( x = 1; x <= 5; x++)
    {
      escreva ( "Digite um numero: " )
      leia ( num )
      se ( num >= 10 )
      {
        se ( num <= 150 )
        {
          intervalo = intervalo + 1
        }
      }
    }

    escreva( "Ao total, foram digitados ", intervalo, " numeros no intervalo entre 10 e 150" )
  }
}
