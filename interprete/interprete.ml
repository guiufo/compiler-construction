module Amb = AmbInterp
module A = Ast
module S = Sast
module T = Tast

exception Valor_de_retorno of T.expressao

let obtem_nome_tipo_var exp = let open T in
  match exp with
  | ExpVar (nome,tipo) -> (nome, tipo)
  | _ -> failwith "obtem_nome_tipo_var: nao eh variavel"

let pega_int exp =
  match exp with
  |  T.ExpInt (i,_) -> i
  | _ -> failwith "pega_int: nao eh inteiro"

let pega_string exp =
  match exp with
  |  T.ExpString (s,_) -> s
  | _ -> failwith "pega_string: nao eh string"

let pega_real exp =
  match exp with
  |  T.ExpFloat (s,_) -> s
  | _ -> failwith "pega_real: nao eh real"

let pega_bool exp =
  match exp with
  |  T.ExpBool (b,_) -> b
  | _ -> failwith "pega_bool: nao eh booleano"

type classe_op = Aritmetico | Relacional | Logico

let classifica op =
  let open A in
  match op with
    OuLogico
  | XouLogico
  | ELogico -> Logico
  | Menor
  | Maior
  | Igual
  | MaiorIgual
  | MenorIgual
  | Diferente -> Relacional
  | Soma
  | Subtracao
  | Multiplicacao
  | Potencia
  | Modulo
  | Divisao -> Aritmetico


let rec interpreta_exp amb exp =
  let open A in
  let open T in
  match exp with
  | ExpVoid
  | ExpInt _
  | ExpString _
  | ExpFloat _
  | ExpBool _   -> exp
  | ExpVar _ ->
    let (id,tipo) = obtem_nome_tipo_var exp in
    (* Tenta encontrar o valor da variável no escopo local, se não      *)
    (* encontrar, tenta novamente no escopo que engloba o atual. Prossegue-se *)
    (* assim até encontrar o valor em algum escopo englobante ou até    *)
    (* encontrar o escopo global. Se em algum lugar for encontrado,         *)
    (* devolve-se o valor. Em caso contrário, devolve uma exceção       *)
    (match (Amb.busca amb id) with
     | Amb.EntVar (tipo, v) ->
       (match v with
        | None -> failwith ("variável nao inicializada: " ^ id)
        | Some valor -> valor
       )
     |  _ -> failwith "interpreta_exp: expvar"
    )
  | ExpOp ((op,top), (esq, tesq), (dir,tdir)) ->
    let  vesq = interpreta_exp amb esq
    and vdir = interpreta_exp amb dir in

    let interpreta_aritmetico () =
      (match tesq with
       | TipoInteiro ->
         (match op with
          | Soma ->     ExpInt (pega_int vesq + pega_int vdir, top)
          | Subtracao -> ExpInt (pega_int vesq - pega_int vdir, top)
          | Multiplicacao ->     ExpInt (pega_int vesq * pega_int vdir, top)
          | Divisao  ->      ExpInt (pega_int vesq / pega_int vdir, top)
	  | Modulo -> ExpInt (pega_int vesq mod pega_int vdir, top)
          | _ -> failwith "interpreta_aritmetico"
         )
       | TipoReal ->
         (match op with
          | Soma ->     ExpFloat (pega_real vesq +. pega_real vdir, top)
          | Subtracao -> ExpFloat (pega_real vesq -. pega_real vdir, top)
          | Multiplicacao ->     ExpFloat (pega_real vesq *. pega_real vdir, top)
          | Divisao  ->      ExpFloat (pega_real vesq /. pega_real vdir, top)
          | _ -> failwith "interpreta_aritmetico"
         )
       | _ -> failwith "interpreta_aritmetico"
      )

    and interpreta_relacional () =
      (match tesq with
       | TipoInteiro ->
         (match op with
          | Menor -> ExpBool (pega_int vesq < pega_int vdir, top)
          | Maior  -> ExpBool (pega_int vesq > pega_int vdir, top)
          | Igual   -> ExpBool (pega_int vesq == pega_int vdir, top)
          | Diferente   -> ExpBool (pega_int vesq != pega_int vdir, top)
          | MenorIgual -> ExpBool (pega_int vesq <= pega_int vdir, top)
          | MaiorIgual -> ExpBool (pega_int vesq >= pega_int vdir, top)
          | _ -> failwith "interpreta_relacional"
         )
       | TipoCaractere ->
         (match op with
          | Menor -> ExpBool (pega_string vesq < pega_string vdir, top)
          | Maior  -> ExpBool (pega_string vesq > pega_string vdir, top)
          | Igual   -> ExpBool (pega_string vesq = pega_string vdir, top)
          | Diferente   -> ExpBool (pega_string vesq != pega_string vdir, top)
          | MenorIgual -> ExpBool (pega_string vesq <= pega_string vdir, top)
          | MaiorIgual -> ExpBool (pega_string vesq >= pega_string vdir, top)
          | _ -> failwith "interpreta_relacional"
         )
       | TipoReal ->
         (match op with
          | Menor -> ExpBool (pega_real vesq < pega_real vdir, top)
          | Maior  -> ExpBool (pega_real vesq > pega_real vdir, top)
          | Igual   -> ExpBool (pega_real vesq == pega_real vdir, top)
          | Diferente   -> ExpBool (pega_real vesq != pega_real vdir, top)
          | MenorIgual -> ExpBool (pega_real vesq <= pega_real vdir, top)
          | MaiorIgual -> ExpBool (pega_real vesq >= pega_real vdir, top)
          | _ -> failwith "interpreta_relacional"
         )
       | TipoBooleano ->
         (match op with
          | Menor -> ExpBool (pega_bool vesq < pega_bool vdir, top)
          | Maior  -> ExpBool (pega_bool vesq > pega_bool vdir, top)
          | Igual   -> ExpBool (pega_bool vesq == pega_bool vdir, top)
          | Diferente   -> ExpBool (pega_bool vesq != pega_bool vdir, top)
          | MenorIgual -> ExpBool (pega_bool vesq <= pega_bool vdir, top)
          | MaiorIgual -> ExpBool (pega_bool vesq >= pega_bool vdir, top)
          | _ -> failwith "interpreta_relacional"
         )
       | _ ->  failwith "interpreta_relacional"
      )

    and interpreta_logico () =
      (match tesq with
       | TipoBooleano ->
         (match op with
          | OuLogico -> ExpBool (pega_bool vesq || pega_bool vdir, top)
          | ELogico ->   ExpBool (pega_bool vesq && pega_bool vdir, top)
          | _ ->  failwith "interpreta_logico"
         )
       | _ ->  failwith "interpreta_logico"
      )

    in
    let valor = (match (classifica op) with
          Aritmetico -> interpreta_aritmetico ()
        | Relacional -> interpreta_relacional ()
        | Logico -> interpreta_logico ()
      )
    in
      valor

  | ExpFunCall (id, args, tipo) ->
    let open Amb in
    ( match (Amb.busca amb id) with
      | Amb.EntFun {tipo_fn; formais; locais; corpo} ->
           (* Interpreta cada um dos argumentos *)
           let vargs = List.map (interpreta_exp amb) args in
           (* Associa os argumentos aos parâmetros formais *)
           let vformais = List.map2 (fun (n,t) v -> (n, t, Some v)) formais vargs
           in interpreta_fun amb id vformais locais corpo
      | _ -> failwith "interpreta_exp: expchamada"
    )

and interpreta_fun amb fn_nome fn_formais fn_locais fn_corpo =
  let open A in
 (* Estende o ambiente global, adicionando um ambiente local *)
  let ambfn = Amb.novo_escopo amb in
   let insere_local  d =
    match d with
      (DecVar (v,t)) -> Amb.insere_local ambfn (fst v)  t None
  in
  (* Associa os argumentos aos parâmetros e insere no novo ambiente *)
  let insere_parametro (n,t,v) = Amb.insere_param ambfn n t v in
  let _ = List.iter insere_parametro fn_formais in
  (* Insere as variáveis locais no novo ambiente *)
    let _ = List.iter insere_local fn_locais in
    (* Interpreta cada comando presente no corpo da função usando o novo
       ambiente *)
  try
    let _ = List.iter (interpreta_cmd ambfn) fn_corpo in T.ExpVoid
    with
       Valor_de_retorno expret -> expret

and interpreta_cmd amb cmd =
  let open A in
  let open T in
  match cmd with
    Retorne exp ->
    (* Levantar uma exceção foi necessária pois, pela semântica do comando de
        retorno, sempre que ele for encontrado em uma função, a computação
        deve parar retornando o valor indicado, sem realizar os demais comandos.
    *)
    (match exp with
     (* Se a função não retornar nada, então retorne ExpVoid *)
       None -> raise (Valor_de_retorno ExpVoid)
     | Some e ->
       (* Avalia a expressão e retorne o resultado *)
       let e1 = interpreta_exp amb e in
       raise (Valor_de_retorno e1)
    )

  | Se (teste, entao, senao) ->
    let teste1 = interpreta_exp amb teste in
    (match teste1 with
       ExpBool (true,_) ->
       (* Interpreta cada comando do bloco 'então' *)
       List.iter (interpreta_cmd amb) entao
     | _ ->
       (* Interpreta cada comando do bloco 'senão', se houver *)
       (match senao with
          None -> ()
        | Some bloco -> List.iter (interpreta_cmd amb) bloco
       )
    )

  | Attrib (elem, exp) ->
    (* Interpreta o lado direito da atribuição *)
    let exp = interpreta_exp amb exp
    (* Faz o mesmo para o lado esquerdo *)
    and (elem1,tipo) = obtem_nome_tipo_var elem in
    Amb.atualiza_var amb elem1 tipo (Some exp)

(* | Para (cmd1, exp, cmd2) ->
    (match cmd1 with
      | Attrib(v, exp1) ->
        (* Interpreta o lado direito da atribuição *)
        let exp2 = interpreta_exp amb exp1
        (* Faz o mesmo para o lado esquerdo *)
        and (elem1,tipo) = obtem_nome_tipo_var v in
        Amb.atualiza_var amb elem1 tipo (Some exp2);

        (match exp2 with
          | ExpInt (val1, _) ->
          (match (interpreta_exp amb exp) with
            | ExpInt (val2, _) ->
                              for var = val1 to val2 do

(*                                let expAux = interpreta_exp amb exp1;*)

                                (* Faz o mesmo para o lado esquerdo *)
(*                                and (elemAux,tipoAux) = obtem_nome_tipo_var v in
                                Amb.atualiza_var amb elemAux tipoAux (Some (ExpInt (var, )))
*)
                                interpreta_cmd amb cmd2
                              done
            | _ -> failwith "segunda expressao invalida"
          )
          | _ -> failwith "expressao invalida"
        )
      | _ -> failwith "comando invalido"
    ) *)

  | Enquanto (exp, cmd) ->
    (match (interpreta_exp amb exp) with
      | ExpBool (v, _) ->
        (let value = ref v in
          while !value do
            List.iter (interpreta_cmd amb) cmd;
            match (interpreta_exp amb exp) with
            | ExpBool(v, _) -> value := v
            | _ -> failwith "Condicao nao satisfeita"
          done
        )
      | _ -> failwith "Condicao invalida"
    )

  | Chamada exp -> ignore( interpreta_exp amb exp)

  | Leia exps ->
    (* Obtem os nomes e os tipos de cada um dos argumentos *)
    let nts = List.map (obtem_nome_tipo_var) exps in
    let leia_var (nome,tipo) =
      let valor =
        (match tipo with
         | A.TipoInteiro    -> T.ExpInt    (read_int (),  tipo)
         | A.TipoReal    -> T.ExpFloat (read_float (),  tipo)
         | A.TipoCaractere -> T.ExpString (read_line (), tipo)
         | _ -> failwith "leia_var: nao implementado"
        )
      in  Amb.atualiza_var amb nome tipo (Some valor)
    in
    (* Lê o valor para cada argumento e atualiza o ambiente *)
    List.iter leia_var nts

  | Escreva exps ->
    (* Interpreta cada argumento da função 'saida' *)
    let exps = List.map (interpreta_exp amb) exps in
    let imprima exp =
      (match exp with
       | T.ExpInt (n,_) ->      let _ = print_int n in print_string " "
       | T.ExpString (s,_) -> let _ = print_string s in print_string " "
       | T.ExpReal (r, _) -> let _ = print_float r in print_string " "
       | T.ExpBool (b,_) ->
         let _ = print_string (if b then "true" else "false")
         in print_string " "
       | _ -> failwith "imprima: nao implementado"
      )
    in
    List.iter imprima exps

  | Escreval exps ->
    (* Interpreta cada argumento da função 'saida' *)
    let exps = List.map (interpreta_exp amb) exps in
    let imprima exp =
      (match exp with
       | T.ExpInt (n,_) ->      let _ = print_int n in print_string " "
       | T.ExpString (s,_) -> let _ = print_string s in print_string " "
       | T.ExpFloat (r, _) -> let _ = print_float r in print_string " "
       | T.ExpBool (b,_) ->
         let _ = print_string (if b then "true" else "false")
         in print_string " "
       | _ -> failwith "imprima: nao implementado"
      )
    in
    let _ = List.iter imprima exps in
    print_newline ()

let insere_declaracao_var amb dec =
    match dec with
        A.DecVar (nome, tipo) ->  Amb.insere_local amb (fst nome) tipo None

let insere_declaracao_fun amb dec =
  let open A in
    match dec with
      Funcao {fn_nome; fn_prms; fn_tiporeturn; fn_locais; fn_cmds} ->
        let nome = fst fn_nome in
        let formais = List.map (fun (n,t) -> ((fst n), t)) fn_prms in
        Amb.insere_fun amb nome formais fn_locais fn_tiporeturn fn_cmds

(* Lista de cabeçalhos das funções pré definidas *)
let fn_predefs = let open A in [
    ("read", [("x", TipoInteiro); ("y", TipoInteiro)], TipoVoid, []);
    ("write",     [("x", TipoInteiro); ("y", TipoInteiro)], TipoVoid, []);
    ("readln", [("x", TipoInteiro); ("y", TipoInteiro)], TipoVoid, []);
    ("writeln",     [("x", TipoInteiro); ("y", TipoInteiro)], TipoVoid, []);
]

(* insere as funções pré definidas no ambiente global *)
let declara_predefinidas amb =
  List.iter (fun (n,ps,tr,c) -> Amb.insere_fun amb n ps [] tr c) fn_predefs

let interprete ast =
  (* cria ambiente global inicialmente vazio *)
  let amb_global = Amb.novo_amb [] in
  let _ = declara_predefinidas amb_global in
  let (A.Programa (ident,decs_funs,decs_globais,corpo)) = ast in
  let _ = List.iter (insere_declaracao_var amb_global) decs_globais in
  let _ = List.iter (insere_declaracao_fun amb_global) decs_funs in
  (* Interpreta a função principal *)
  let resultado = List.iter (interpreta_cmd amb_global) corpo in
  resultado
