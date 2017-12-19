module Amb = AmbInterp
module A = Ast
module S = Sast
module T = Tast

exception Valor_de_retorno of T.expressao

let obtem_nome_tipo_var exp = let open T in
  match exp with
  | ExpVar (v,tipo) ->
    (match v with
      | A.VarSimples (nome,_) -> (nome,tipo)
    )
  | _ -> failwith "obtem_nome_tipo_var: nao eh variavel"

let pega_int exp =
  match exp with
  |  T.ExpInt (i,_) -> i
  | _ -> failwith "pega_int: nao eh inteiro"

let pega_float exp =
  match exp with
  |  T.ExpReal (i,_) -> i
  | _ -> failwith "pega_float: nao eh real"

let pega_string exp =
  match exp with
  |  T.ExpCaractere (s,_) -> s
  | _ -> failwith "pega_string: nao eh string"

let pega_bool exp =
  match exp with
  |  T.ExpLogico (b,_) -> b
  | _ -> failwith "pega_bool: nao eh booleano"

type classe_op = Aritmetico | Relacional | Logico

let classifica op =
  let open A in
  match op with
    Ou
  | AND -> Logico
  | Menor
  | MenorIgual
  | Maior
  | MaiorIgual
  | Igual
  | Difer -> Relacional
  | Mais
  | Menos
  | Mult
  | Div -> Aritmetico


let rec interpreta_exp amb exp =
  let open A in
  let open T in
  match exp with
  | ExpVoid
  | ExpInt _
  | ExpReal _
  | ExpCaractere _
  | ExpLogico _   -> exp
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
          | Mais ->     ExpInt (pega_int vesq + pega_int vdir, top)
          | Menos -> ExpInt (pega_int vesq - pega_int vdir, top)
          | Mult ->     ExpInt (pega_int vesq * pega_int vdir, top)
          | Div  ->      ExpInt (pega_int vesq / pega_int vdir, top)
          | _ -> failwith "interpreta_aritmetico"
         )

       | TipoReal ->
         (match op with
          | Mais ->     ExpInt (pega_int vesq + pega_int vdir, top)
          | Menos -> ExpInt (pega_int vesq - pega_int vdir, top)
          | Mult ->     ExpInt (pega_int vesq * pega_int vdir, top)
          | Div  ->      ExpInt (pega_int vesq / pega_int vdir, top)
          | _ -> failwith "interpreta_aritmetico"
         )
        | _ -> failwith "interpreta_aritmetico"
      )

    and interpreta_relacional () =
      (match tesq with
       | TipoInteiro ->
         (match op with
          | Menor -> ExpLogico (pega_int vesq < pega_int vdir, top)
	  | MenorIgual -> ExpLogico (pega_int vesq <= pega_int vdir, top)
          | Maior  -> ExpLogico (pega_int vesq > pega_int vdir, top)
          | MaiorIgual  -> ExpLogico (pega_int vesq >= pega_int vdir, top)
          | Igual   -> ExpLogico (pega_int vesq == pega_int vdir, top)
          | Difer   -> ExpLogico (pega_int vesq != pega_int vdir, top)
          | _ -> failwith "interpreta_relacional"
         )

       | TipoReal ->
         (match op with
          | Menor -> ExpLogico (pega_float vesq < pega_float vdir, top)
	  | MenorIgual -> ExpLogico (pega_float vesq <= pega_float vdir, top)
          | Maior  -> ExpLogico (pega_float vesq > pega_float vdir, top)
          | MaiorIgual  -> ExpLogico (pega_float vesq >= pega_float vdir, top)
          | Igual   -> ExpLogico (pega_float vesq == pega_float vdir, top)
          | Difer   -> ExpLogico (pega_float vesq != pega_float vdir, top)
          | _ -> failwith "interpreta_relacional"
         )

       | TipoCaractere ->
         (match op with
          | Menor -> ExpLogico (pega_string vesq < pega_string vdir, top)
          | MenorIgual -> ExpLogico (pega_string vesq <= pega_string vdir, top)
          | Maior  -> ExpLogico (pega_string vesq > pega_string vdir, top)
          | MaiorIgual  -> ExpLogico (pega_string vesq >= pega_string vdir, top)
          | Igual   -> ExpLogico (pega_string vesq == pega_string vdir, top)
          | Difer   -> ExpLogico (pega_string vesq != pega_string vdir, top)
          | _ -> failwith "interpreta_relacional"
         )
       | TipoLogico ->
         (match op with
          | Menor -> ExpLogico (pega_bool vesq < pega_bool vdir, top)
          | MenorIgual -> ExpLogico (pega_bool vesq <= pega_bool vdir, top)
          | Maior  -> ExpLogico (pega_bool vesq > pega_bool vdir, top)
          | MaiorIgual  -> ExpLogico (pega_bool vesq >= pega_bool vdir, top)
          | Igual   -> ExpLogico (pega_bool vesq == pega_bool vdir, top)
          | Difer   -> ExpLogico (pega_bool vesq != pega_bool vdir, top)
          | _ -> failwith "interpreta_relacional"
         )
       | _ ->  failwith "interpreta_relacional"
      )

    and interpreta_logico () =
      (match tesq with
       | TipoLogico ->
         (match op with
          | Ou -> ExpLogico (pega_bool vesq || pega_bool vdir, top)
          | AND ->   ExpLogico (pega_bool vesq && pega_bool vdir, top)
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

  | ExpChamada (id, args, tipo) ->
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
      (Var (v,t)) -> Amb.insere_local ambfn (fst v)  t None
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
    CmdRetorno exp ->
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

  | CmdSe (teste, entao, senao) ->
    let teste1 = interpreta_exp amb teste in
    (match teste1 with
       ExpLogico (true,_) ->
       (* Interpreta cada comando do bloco 'então' *)
       List.iter (interpreta_cmd amb) entao
     | _ ->
       (* Interpreta cada comando do bloco 'senão', se houver *)
       (match senao with
          None -> ()
        | Some bloco -> List.iter (interpreta_cmd amb) bloco
       )
    )

  | CmdAtrib (elem, exp) ->
    (* Interpreta o lado direito da atribuição *)
    let exp = interpreta_exp amb exp
    (* Faz o mesmo para o lado esquerdo *)
    and (elem1,tipo) = obtem_nome_tipo_var elem in
    Amb.atualiza_var amb elem1 tipo (Some exp)

  | CmdChamada exp -> ignore( interpreta_exp amb exp)

  | CmdLeia exps ->
    (* Obtem os nomes e os tipos de cada um dos argumentos *)
    let nts = List.map (obtem_nome_tipo_var) exps in
    let leia_var (nome,tipo) =
      let valor =
        (match tipo with
         | A.TipoInteiro    -> T.ExpInt    (read_int (),  tipo)
	 | A.TipoReal    -> T.ExpReal    (read_float (),  tipo)
         | A.TipoCaractere -> T.ExpCaractere (read_line (), tipo)
         | _ -> failwith "leia_var: nao implementado"
        )
      in  Amb.atualiza_var amb nome tipo (Some valor)
    in
    (* Lê o valor para cada argumento e atualiza o ambiente *)
    List.iter leia_var nts


  | CmdEscreva exps ->
    (* Interpreta cada argumento da função 'saida' *)
    let exps = List.map (interpreta_exp amb) exps in
    let imprima exp =
      (match exp with
       | T.ExpInt (n,_) ->      let _ = print_int n in print_string " "
       | T.ExpReal (r,_) ->      let _ = print_float r in print_string " "
       | T.ExpCaractere (s,_) -> let _ = print_string s in print_string " "
       | T.ExpLogico (b,_) ->
         let _ = print_string (if b then "true" else "false")
         in print_string " "
       | _ -> failwith "imprima: nao implementado"
      )
    in
    let _ = List.iter imprima exps in
    print_newline ()

    | CmdEnquanto (cond, cmds) ->
        let rec laco cond cmds =
          let condResp = interpreta_exp amb cond in
                (match condResp with
                  | ExpLogico (true,_) ->
                      (* Interpreta cada comando do bloco 'então' *)
                      let _ = List.iter (interpreta_cmd amb) cmds in
                        laco cond cmds
                  | _ -> ())
        in laco cond cmds

let insere_declaracao_var amb dec =
    match dec with
        A.Var (nome, tipo) ->  Amb.insere_local amb (fst nome) tipo None

let insere_declaracao_fun amb dec =
  let open A in
    match dec with
      DecFun {fn_nome; fn_tiporet; fn_formais; fn_locais; fn_corpo} ->
        let nome = fst fn_nome in
        let formais = List.map (fun (n,t) -> ((fst n), t)) fn_formais in
        Amb.insere_fun amb nome formais fn_locais fn_tiporet fn_corpo


(* Lista de cabeçalhos das funções pré definidas *)
let fn_predefs = let open A in [
   ("entrada", [("x", TipoInteiro); ("y", TipoInteiro)], TipoVoid, []);
   ("saida",   [("x", TipoInteiro); ("y", TipoInteiro)], TipoVoid, [])
]

(* insere as funções pré definidas no ambiente global *)
let declara_predefinidas amb =
  List.iter (fun (n,ps,tr,c) -> Amb.insere_fun amb n ps [] tr c) fn_predefs

let interprete ast =
  (* cria ambiente global inicialmente vazio *)
  let amb_global = Amb.novo_amb [] in
  let _ = declara_predefinidas amb_global in
  let (A.Algoritmo (decs_globais, decs_funs, corpo)) = ast in
  let _ = List.iter (insere_declaracao_var amb_global) decs_globais in
  let _ = List.iter (insere_declaracao_fun amb_global) decs_funs in
  (* Interpreta a função principal *)
  let resultado = List.iter (interpreta_cmd amb_global) corpo in
  resultado

