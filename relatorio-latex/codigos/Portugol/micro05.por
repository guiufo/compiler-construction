programa
{
  funcao inicio ()
  {
    cadeia nome, sexo
    inteiro x, h, m
    h = 0
    m = 0

    para ( x = 1; x <= 5; x++)
    {
      escreva ( "Digite o nome: " )
      leia ( nome )
      escreva ( "H - Homem ou M - Mulher: " )
      leia ( sexo )
      escolha ( sexo )
      {
        caso 'H':
          h = h + 1
          pare
        caso 'M':
          m = m + 1
          pare
        caso contrario:
          escreva ( "Sexo soh pode ser H ou M!" )
      }
    }

    escreva ( "Foram inseridos ", h, " homens" )
    escreva ( "Foram inseridos ", m, " mulheres" )
  }
}
