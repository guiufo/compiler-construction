
%{
open Lexing
open Ast
open Sast
%}

%token <int * Lexing.position> LITINT
%token <Lexing.position> INT
%token <float * Lexing.position> LITREAL
%token <Lexing.position> REAL
%token <string * Lexing.position> ID
%token <string * Lexing.position> LITCARACTERE
%token <Lexing.position> CARACTERE
%token <bool * Lexing.position> LITLOGICO
%token <Lexing.position> LOGICO
%token <Lexing.position> ALGORITMO
%token <Lexing.position> VAR
%token <Lexing.position> INICIO
%token <Lexing.position> FIM
%token <Lexing.position> VIRG DOISPT PTV
%token <Lexing.position> APAR FPAR
%token <Lexing.position> SE ENTAO SENAO
%token <Lexing.position> FIMSE
%token <Lexing.position> ENQUANTO FACA
%token <Lexing.position> FIMENQUANTO
%token <Lexing.position> ESCREVA
%token <Lexing.position> LEIA
%token <Lexing.position> ATRIB
%token <Lexing.position> MAIS
%token <Lexing.position> MENOS
%token <Lexing.position> MULT
%token <Lexing.position> DIV
%token <Lexing.position> MENOR
%token <Lexing.position> MENORIGUAL
%token <Lexing.position> IGUAL
%token <Lexing.position> DIFER
%token <Lexing.position> MAIOR
%token <Lexing.position> MAIORIGUAL
%token <Lexing.position> E
%token <Lexing.position> OU
%token <Lexing.position> PARA
%token <Lexing.position> FIMPARA
%token <Lexing.position> DE
%token <Lexing.position> ATE
%token <Lexing.position> ESCOLHA
%token <Lexing.position> CASO
%token <Lexing.position> FIMESCOLHA
%token <Lexing.position> FUNCAO
%token <Lexing.position> RETORNE
%token <Lexing.position> FIMFUNCAO
%token EOF

%left OU
%left E
%left IGUAL DIFER
%left MAIOR MENOR MAIORIGUAL MENORIGUAL
%left MAIS MENOS
%left MULT DIV


%start <Sast.expressao Ast.programa> programa

%%

programa: ALGORITMO
	  VAR
            ds = declaracao*
            fs = declaracao_funcao*
          INICIO
            cs = comando*
          FIM
          EOF { Algoritmo (List.flatten ds, fs, cs) }


declaracao: ids = separated_nonempty_list(VIRG, ID) DOISPT t = tipo {
                   List.map (fun id -> Var (id,t)) ids
          }

declaracao_funcao: FUNCAO nome = ID APAR formais = separated_list(VIRG, parametro) FPAR DOISPT tret = tipo
		   VAR
  			ds = declaracao*
  		INICIO
  			cs = comando*
  		FIMFUNCAO {
    			DecFun {
      				fn_nome = nome;
      				fn_tiporet = tret ;
      				fn_formais = formais;
      				fn_locais = List.flatten ds;
      				fn_corpo = cs
    			}
 		}

parametro: nome = ID DOISPT t = tipo { (nome, t) }


tipo: t=tipo_simples  { t }

tipo_simples: INT       { TipoInteiro   }
	    | REAL      { TipoReal }
            | CARACTERE { TipoCaractere }
            | LOGICO    { TipoLogico }

comando: c=comando_atribuicao { c }
       | c=comando_se         { c }
       | c=comando_leia       { c }
       | c=comando_escreva    { c }
       | c=comando_enquanto   { c }
       | c=comando_para       { c }
       | c=comando_escolha    { c }
       | c=comando_chamada    { c }
       | c=comando_retorno    { c }


comando_atribuicao: v=expressao ATRIB e=expressao {
      CmdAtrib (v,e)
}

comando_se: SE teste=expressao ENTAO
               entao=comando+
               senao=option(SENAO cs=comando+ {cs})
            FIMSE { CmdSe (teste, entao, senao) }

comando_leia: LEIA APAR xs=separated_nonempty_list(VIRG, expressao) FPAR {
                   CmdLeia xs
               }

comando_escreva: ESCREVA APAR xs=separated_nonempty_list(VIRG, expressao) FPAR {
                 CmdEscreva xs
             }

comando_enquanto: ENQUANTO teste=expressao FACA
			faca=comando+
		  FIMENQUANTO { CmdEnquanto (teste,faca) }

comando_para: PARA x=variavel DE e1=expressao ATE e2=expressao FACA
		faca=comando+
	      FIMPARA { CmdPara (x, e1, e2, faca) }

comando_escolha: ESCOLHA x=variavel
			 casos=caso+
		 FIMESCOLHA { CmdEscolha (x,casos) }

comando_chamada: exp=chamada PTV { CmdChamada exp }

comando_retorno: RETORNE e=expressao? { CmdRetorno e}

caso: CASO x=expressao
	com=comando+ { Case (x,com) }

expressao:
         | v=variavel     { ExpVar v    }
         | i=LITINT       { ExpInt i    }
	 | f=LITREAL      { ExpReal f   }
         | s=LITCARACTERE { ExpCaractere s }
         | b=LITLOGICO    { ExpLogico b }
	 | e1=expressao op=oper e2=expressao { ExpOp (op, e1, e2) }
         | c=chamada      { c }
 	 | APAR e=expressao FPAR { e }

chamada : nome=ID APAR args=separated_list(VIRG, expressao) FPAR {
             ExpChamada  (nome, args)}

%inline oper:
	| pos = MAIS       { (Mais, pos)       }
        | pos = MENOS      { (Menos, pos)      }
        | pos = MULT       { (Mult, pos)       }
        | pos = DIV        { (Div, pos)        }
        | pos = MENOR      { (Menor, pos)      }
	| pos = MENORIGUAL { (MenorIgual, pos) }
        | pos = IGUAL      { (Igual, pos)      }
        | pos = DIFER      { (Difer, pos)      }
        | pos = MAIOR      { (Maior, pos)      }
	| pos = MAIORIGUAL { (MaiorIgual, pos) }
        | pos = E          { (AND, pos)        }
        | pos = OU         { (Ou, pos)         }

variavel: x=ID       { VarSimples x }
