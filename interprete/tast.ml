open Ast

type expressao = ExpVar of (expressao variavel) * tipo
              | ExpInt of int * tipo
	      | ExpReal of float * tipo
              | ExpCaractere of string * tipo
  	      | ExpVoid
              | ExpLogico of bool * tipo
              | ExpOp of (oper * tipo) * (expressao * tipo) * (expressao * tipo)
              | ExpChamada of ident * (expressao expressoes) * tipo


