{
  open Lexing
  open Printf
  open Sintatico

  exception Erro of string

  let incr_num_linha lexbuf = 
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      { pos with pos_lnum = pos.pos_lnum + 1;
                 pos_bol = pos.pos_cnum
      }

    let pos_atual lexbuf = lexbuf.lex_start_p

}

let digito = ['0' - '9']
let inteiro = digito+
let real = digito+'.'digito+
let logico = ("verdadeiro"|"falso")

let letra = ['a' - 'z' 'A' - 'Z']
let identificador = letra ( letra | digito | '_')*

let brancos = [' ' '\t']+
let novalinha = '\r' | '\n' | "\r\n"

let comentario = "--" [^ '\r' '\n' ]*

rule token = parse
  brancos    { token lexbuf }
| novalinha  { incr_num_linha lexbuf; token lexbuf }
| comentario { token lexbuf }
| "(*"       { comentario_bloco 0 lexbuf }
| '('        { APAR (pos_atual lexbuf) }
| ','	     { VIRG (pos_atual lexbuf) }
| ';'        { PTV (pos_atual lexbuf) }
| ':'	     { DOISPT (pos_atual lexbuf) }
| "<-"	     { ATRIB (pos_atual lexbuf) }
| '+'        { MAIS (pos_atual lexbuf) }
| '-'	     { MENOS (pos_atual lexbuf) }
| '*'	     { MULT (pos_atual lexbuf) }
| '/'	     { DIV (pos_atual lexbuf) }
| ')'        { FPAR (pos_atual lexbuf) }
| '>'	     { MAIOR (pos_atual lexbuf) }
| '<'	     { MENOR (pos_atual lexbuf) }
| '='	     { IGUAL (pos_atual lexbuf) }
| ">="	     { MAIORIGUAL (pos_atual lexbuf) }
| "<="	     { MENORIGUAL (pos_atual lexbuf) }
| "<>"	     { DIFER (pos_atual lexbuf) }
| ":="       { ATRIB (pos_atual lexbuf) }
| "inteiro"  { INT (pos_atual lexbuf) }
| inteiro as num { let numero = int_of_string num in 
                    LITINT (numero, pos_atual lexbuf)  } 
| "real"     { REAL (pos_atual lexbuf) }
| real as num { let numero = float_of_string num in
		  LITREAL (numero, pos_atual lexbuf) }
| "caractere" { CARACTERE (pos_atual lexbuf) }
| "logico"   { LOGICO (pos_atual lexbuf) }
| logico as l { let booleano = bool_of_string l in
		  LITLOGICO (booleano, pos_atual lexbuf) }
| "Algoritmo" { ALGORITMO (pos_atual lexbuf) }
| "Var"	     { VAR (pos_atual lexbuf) }
| "Inicio"   { INICIO (pos_atual lexbuf) }
| "Fimalgoritmo" { FIM (pos_atual lexbuf) }
| "escreva" { ESCREVA (pos_atual lexbuf) }
| "leia"     { LEIA (pos_atual lexbuf) }
| "se"       { SE (pos_atual lexbuf) }
| 'E'	     { E (pos_atual lexbuf) }
| "para"     { PARA (pos_atual lexbuf) }
| "de"	     { DE (pos_atual lexbuf) }
| "ate"      { ATE (pos_atual lexbuf) }
| "fimpara"  { FIMPARA (pos_atual lexbuf) }
| "OU"	     { OU (pos_atual lexbuf) }
| "entao"    { ENTAO (pos_atual lexbuf) }
| "senao"    { SENAO (pos_atual lexbuf) }
| "fimse"    { FIMSE (pos_atual lexbuf) }
| "enquanto"    { ENQUANTO (pos_atual lexbuf) }
| "faca"	{ FACA (pos_atual lexbuf) }
| "fimenquanto" { FIMENQUANTO (pos_atual lexbuf) }
| "escolha"	{ ESCOLHA (pos_atual lexbuf) }
| "caso"	{ CASO (pos_atual lexbuf) }
| "fimescolha"	{ FIMESCOLHA (pos_atual lexbuf) }
| "funcao"    { FUNCAO (pos_atual lexbuf) }
| "retorne"   { RETORNE (pos_atual lexbuf) }
| "fimfuncao" { FIMFUNCAO (pos_atual lexbuf) }
| identificador as id { ID (id, pos_atual lexbuf) }
| '"'   { let buffer = Buffer.create 1 in
            let str = leia_string buffer lexbuf in
               LITCARACTERE (str, pos_atual lexbuf) }
| _ { raise (Erro ("Caracter desconhecido: " ^ Lexing.lexeme lexbuf)) }
| eof        { EOF }

and comentario_bloco n = parse
   "*)"      { if n=0 then token lexbuf 
               else comentario_bloco (n-1) lexbuf }
| "(*"       { comentario_bloco (n+1) lexbuf }
| novalinha  { incr_num_linha lexbuf; comentario_bloco n lexbuf }
| _          { comentario_bloco n lexbuf }
| eof        { raise (Erro "Comentário não terminado") }

and leia_string buffer = parse
   '"'      { Buffer.contents buffer}
| "\\t"     { Buffer.add_char buffer '\t'; leia_string buffer lexbuf }
| "\\n"     { Buffer.add_char buffer '\n'; leia_string buffer lexbuf }
| '\\' '"'  { Buffer.add_char buffer '"'; leia_string buffer lexbuf }
| '\\' '\\' { Buffer.add_char buffer '\\'; leia_string buffer lexbuf }
| _ as c    { Buffer.add_char buffer c; leia_string buffer lexbuf }
| eof       { raise (Erro "A string não foi terminada") }



