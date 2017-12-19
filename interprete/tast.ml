open Ast

type expressao = ExpVar of identificador pos
		  |ExpOp of (op * tipo ) * (expressao * tipo) * (expressao * tipo)
		  |ExpFunCall of identificador * expressao fargs * tipo 
		  |ExpString of string * tipo
		  |ExpInt of int * tipo
		  |ExpFloat of float * tipo
		  |ExpChar of char * tipo
			|ExpBool of bool * tipo
			|ExpVoid
		(*  |ExpNot of expressao * tipo *)

