(* The type of the abstract syntax tree (AST). *)
open Lexing

type ident = string
type 'a pos =  'a * Lexing.position (* tipo e posição no arquivo fonte *)

type 'expr programa = Algoritmo of declaracoes * ('expr funcoes) * ('expr comandos)
and declaracoes = declaracao list
and 'expr funcoes = ('expr funcao) list
and 'expr comandos = ('expr comando) list

and declaracao = Var of (ident pos) * tipo

and 'expr funcao = DecFun of ('expr decfn)

and 'expr decfn = {
  fn_nome:    ident pos;
  fn_tiporet: tipo;
  fn_formais: (ident pos * tipo) list;
  fn_locais:  declaracoes;
  fn_corpo:   'expr comandos
}
                                     
and tipo = TipoInteiro
	 | TipoReal
         | TipoCaractere
         | TipoLogico
	 | TipoVoid

and 'expr comando =
	    | CmdAtrib of 'expr * 'expr
            | CmdSe of 'expr * ('expr comandos) * ('expr comandos option)
            | CmdLeia of ('expr expressoes)
            | CmdEscreva of ('expr expressoes)
	    | CmdEnquanto of 'expr * ('expr comandos)
	    | CmdPara of ('expr variavel) * 'expr * 'expr * ('expr comandos)
	    | CmdEscolha of ('expr variavel) * ('expr casos)
  	    | CmdRetorno of 'expr option
  	    | CmdChamada of 'expr

and 'expr casos = ('expr caso) list
and 'expr caso = Case of 'expr * ('expr comandos)

and 'expr variaveis = ('expr variavel) list
and 'expr variavel = VarSimples of ident pos

and 'expr expressoes = 'expr list             

and oper = Mais
         | Menos
         | Mult
         | Div
         | Menor
	 | MenorIgual
         | Igual
         | Difer
         | Maior
	 | MaiorIgual
         | AND
         | Ou
