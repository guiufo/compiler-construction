programa
{
  funcao inicio ()
  {
    real preco, venda, novo_preco
    escreva ( "Digite o preco: " )
    leia ( preco )
    escreva ( "Digite a venda: " )
    leia ( venda )

    se ( venda < 500 ou preco < 30)
    {
      novo_preco = preco + 10/100 * preco
    }
    senao
    {
      se ( (venda >= 500 e venda < 1200) ou (preco >= 30 e preco < 80) )
      {
        novo_preco = preco + 15/100 * preco
      }
      senao
      {
        se ( venda >= 1200 ou preco >= 80 )
        {
          novo_preco = preco - 20/100 * preco
        }
      }
    }

    escreva ( "O novo preco eh ", novo_preco, "\n" )
  }
}
