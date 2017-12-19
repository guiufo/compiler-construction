open Printf
open Lexing

open Ast
exception Erro_Sintatico of string

module S = MenhirLib.General (* Streams *)
module I = Sintatico.MenhirInterpreter

open Semantico

let message =
  fun s ->
    match s with
    | 0 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 1 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 2 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 139 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 32 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 74 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 75 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 128 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 130 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 127 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 116 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 76 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 134 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 78 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 140 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 79 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 81 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 82 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 83 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 84 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 85 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 86 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 125 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 104 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 42 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 43 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 44 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 47 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 48 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 51 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 52 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 55 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 56 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 53 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 54 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 57 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 58 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 59 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 60 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 61 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 62 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 63 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 64 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 49 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 65 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 66 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 105 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 106 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 87 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 88 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 72 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 71 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 37 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 38 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 118 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 141 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 91 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 92 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 95 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 96 ->
        "<YOUR SYNTAX ERROR MESSAGE HERE>\n"
    | 97 ->
        "<Caso sem comandos>\n"
    | 98 ->
        "<Caso sem Variavel para ser analisada>\n"
    | 123 ->
        "<Bloco escolha nao fechado>\n"
    | 99 ->
        "<Bloco enquanto sem teste>\n"
    | 100 ->
        "<Sintaxe enquanto errada>\n"
    | 101 ->
        "<Comando enquanto sem comandos>\n"
    | 102 ->
        "<Bloco enquanto nao fechado>\n"
    | 39 ->
        "<Sem expressao entre parenteses>\n"
    | 41 ->
        "<Expressoes sem operadores>\n"
    | 4 ->
        "<Virgula a mais>\n"
    | 3 ->
        "<Erro nas declara\195\167\195\181es>\n"
    | 7 ->
        "<Sem tipo declarado>\n"
    | 136 ->
        "<Sem declara\195\167\195\181es>\n"
    | 15 ->
        "<Palavra funcao fora de sintaxe>\n"
    | 16 ->
        "<Parametros n\195\163o declarados>\n"
    | 17 ->
        "<Sem fechamento de parenteses>\n"
    | 18 ->
        "<sem tipo da variavel>\n"
    | 19 ->
        "<sem tipo da variavel>\n"
    | 23 ->
        "<V\195\173rgula a mais>\n"
    | 22 ->
        "<Sem fechamento de parenteses>\n"
    | 26 ->
        "<Sem tipo de retorno da fun\195\167\195\163o>\n"
    | 27 ->
        "<Sem tipo de retorno da fun\195\167\195\163o>\n"
    | 28 ->
        "<Sem campo de declara\195\167\195\181es>\n"
    | 29 ->
        "<Fun\195\167\195\163o sem variaveis>\n"
    | 31 ->
        "<Func\195\163o sem comandos>\n"
    | 132 ->
        "<Sem termino da fun\195\167\195\163o>\n"
    | 30 ->
        "<Sem inicio da funcao>\n"
    | 143 ->
        "<funcao n\195\163o declarada>\n"
    | _ ->
        raise Not_found
let posicao lexbuf =
    let pos = lexbuf.lex_curr_p in
    let lin = pos.pos_lnum
    and col = pos.pos_cnum - pos.pos_bol - 1 in
    sprintf "linha %d, coluna %d" lin col

(* [pilha checkpoint] extrai a pilha do autômato LR(1) contida em checkpoint *)

let pilha checkpoint =
  match checkpoint with
  | I.HandlingError amb -> I.stack amb
  | _ -> assert false (* Isso não pode acontecer *)

let estado checkpoint : int =
  match Lazy.force (pilha checkpoint) with
  | S.Nil -> (* O parser está no estado inicial *)
     0
  | S.Cons (I.Element (s, _, _, _), _) ->
     I.number s

let sucesso v = Some v

let falha lexbuf (checkpoint : (Sast.expressao Ast.programa) I.checkpoint) =
  let estado_atual = estado checkpoint in
  let msg = message estado_atual in
  raise (Erro_Sintatico (Printf.sprintf "%d - %s.\n"
                                      (Lexing.lexeme_start lexbuf) msg))

let loop lexbuf resultado =
  let fornecedor = I.lexer_lexbuf_to_supplier Lexico.token lexbuf in
  I.loop_handle sucesso (falha lexbuf) fornecedor resultado


let parse_com_erro lexbuf =
  try
    Some (loop lexbuf (Sintatico.Incremental.programa lexbuf.lex_curr_p))
  with
  | Lexico.Erro msg ->
     printf "Erro lexico na %s:\n\t%s\n" (posicao lexbuf) msg;
     None
  | Erro_Sintatico msg ->
     printf "Erro sintático na %s %s\n" (posicao lexbuf) msg;
     None

let parse s =
  let lexbuf = Lexing.from_string s in
  let ast = parse_com_erro lexbuf in
  ast

let parse_arq nome =
  let ic = open_in nome in
  let lexbuf = Lexing.from_channel ic in
  let ast = parse_com_erro lexbuf in
  let _ = close_in ic in
  ast

let verifica_tipos nome =
  let ast = parse_arq nome in
  match ast with
    Some (Some ast) -> semantico ast
  | _ -> failwith "Nada a fazer!\n"

let interprete nome =
  let tast,amb = verifica_tipos nome in
  Interprete.interprete tast
