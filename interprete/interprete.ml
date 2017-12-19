module Amb = AmbInterp
module A = Ast
module S = Sast
module T = Tast

exception Valor_de_retorno of T.expressao

let obtem_nome_tipo_var exp = let open T in
  match exp with
    | ExpVar (nome,tipo) -> (nome,tipo)
    | _                  -> failwith "obtem_nome_tipo_var1: nao eh variavel"

let pega_int exp =
  match exp with
  |  T.ExpInt (i,_) -> i
  | _ -> failwith "pega_int: nao eh inteiro"

let pega_float exp = match exp with
  | T.ExpFloat (f,_)-> f
  | _               -> failwith "pega_float: nao eh inteiro"

let pega_str exp =
  match exp with
  |  T.ExpString (s,_) -> s
  | _ -> failwith "pega_string: nao eh string"

let pega_bool exp =
  match exp with
  |  T.ExpBool (b,_) -> b
  | _ -> failwith "pega_bool: nao eh booleano"

type classe_op = Aritmetico | Relacional | Logico

let classifica op =
  let open A in
  match op with
  | OuLogico
  | ELogico
  | XouLogico  -> Logico
  | Menor
  | MenorIgual
  | Maior
  | MaiorIgual
  | Igual
  | Diferente -> Relacional
  | Soma
  | Subtracao
  | Multiplicacao
  | Divisao
  | Potencia
  | Modulo -> Aritmetico


let rec interpreta_exp amb exp =
  let open A in
  let open T in
  match exp with
  | ExpFloat  _
  | ExpInt    _
  | ExpString _
  | ExpBool   _   -> exp
  | ExpVar (nome, tipo) ->
      (match (Amb.busca amb nome) with
        | Amb.EntVar (_, v) ->
          (match v with
            | Some valor -> valor
            | None       -> failwith "variável nao inicializada: "
          )
        |  _ -> failwith "interpreta_exp: expvar"
      )
  | ExpOp ((op,top), (esq, tesq), (dir,tdir)) ->
    let  vesq = interpreta_exp amb esq
    and vdir = interpreta_exp amb dir in

    let interpreta_aritmetico () =
    (
      match tesq with
    | TipoInteiro ->
       (
        match op with
        | Soma -> ExpInt (pega_int vesq + pega_int vdir, top)
        | Subtracao -> ExpInt(pega_int vesq - pega_int vdir, top)
        | Multiplicacao -> ExpInt (pega_int vesq * pega_int vdir, top)
        | Divisao -> ExpInt (pega_int vesq / pega_int vdir, top)
        | _     -> failwith "interpreta_aritmetico"
       )
     | _ -> failwith "interpreta_aritmetico"
    )
    and interpreta_relacional () =
        (match tesq with
          | TipoInteiro ->
            (match op with
              | MaiorIgual -> ExpBool (pega_int vesq >= pega_int vdir, top)
              | MenorIgual -> ExpBool (pega_int vesq <= pega_int vdir, top)
              | Menor      -> ExpBool (pega_int vesq <  pega_int vdir, top)
              | Maior      -> ExpBool (pega_int vesq >  pega_int vdir, top)
              | Igual      -> ExpBool (pega_int vesq == pega_int vdir, top)
              | Diferente  -> ExpBool (pega_int vesq != pega_int vdir, top)
              | _          -> failwith "interpreta_relacional"
            )
          | TipoCaractere ->
            (match op with
              | MaiorIgual -> ExpBool (pega_str vesq >= pega_str vdir, top)
              | MenorIgual -> ExpBool (pega_str vesq <= pega_str vdir, top)
              | Menor      -> ExpBool (pega_str vesq <  pega_str vdir, top)
              | Maior      -> ExpBool (pega_str vesq >  pega_str vdir, top)
              | Igual      -> ExpBool (pega_str vesq == pega_str vdir, top)
              | Diferente  -> ExpBool (pega_str vesq != pega_str vdir, top)
              | _          -> failwith "interpreta_relacional"
            )
          | TipoBooleano ->
            (match op with
              | MaiorIgual -> ExpBool (pega_bool vesq >= pega_bool vdir, top)
              | MenorIgual -> ExpBool (pega_bool vesq <= pega_bool vdir, top)
              | Menor      -> ExpBool (pega_bool vesq <  pega_bool vdir, top)
              | Maior      -> ExpBool (pega_bool vesq >  pega_bool vdir, top)
              | Igual      -> ExpBool (pega_bool vesq == pega_bool vdir, top)
              | Diferente  -> ExpBool (pega_bool vesq != pega_bool vdir, top)
              | _          -> failwith "interpreta_relacional"
            )
          | TipoFloat ->
            (match op with
              | MaiorIgual -> ExpBool (pega_float vesq == pega_float vdir, top)
              | MenorIgual -> ExpBool (pega_float vesq == pega_float vdir, top)
              | Menor      -> ExpBool (pega_float vesq <  pega_float vdir, top)
              | Maior      -> ExpBool (pega_float vesq >  pega_float vdir, top)
              | Igual      -> ExpBool (pega_float vesq == pega_float vdir, top)
              | Diferente  -> ExpBool (pega_float vesq != pega_float vdir, top)
              | _          -> failwith "interpreta_relacional"
            )
          | _ ->  failwith "interpreta_relacional"
        )

    and interpreta_logico () =
      (match tesq with
       | TipoBooleano ->
         (match op with
          | OuLogico ->  ExpBool (pega_bool vesq || pega_bool vdir, top)
          | ELogico ->  ExpBool (pega_bool vesq && pega_bool vdir, top)
          | _ ->  failwith "interpreta_logico"
         )
       | _ ->  failwith "interpreta_logico"
      )

    in
    let valor = (match (classifica op) with
          Aritmetico -> interpreta_aritmetico ()
        | Relacional -> interpreta_relacional ()
        | Logico     -> interpreta_logico ()
      )
    in
      valor

  | ExpOp ((op, top), (exp, texp)) ->
      let vexp = interpreta_exp amb exp in
      let interpreta_not () =
       (match texp with
        | A.TipoBooleano -> ExpBool (not (pega_bool vexp), top)
        | _          -> failwith "Operador unario indefinido")
      and interpreta_negativo () =
       (match texp with
        | A.TipoInteiro   -> ExpInt   (-1   *  pega_int   vexp, top)
        | A.TipoFloat -> ExpFloat (-1.0 *. pega_float vexp, top)
        | _           -> failwith "Operador unario indefinido")
      in
      let valor =
       (match op with
          (* | NEGACAO   -> interpreta_not () *)
          | Subtracao -> interpreta_negativo ()
          | _     -> failwith "Operador unario indefinido")
      in  valor
  | ExpFunCall (id, args, tipo) ->
    let open Amb in
      (match (Amb.busca amb id) with
        | Amb.EntFun {tipo_fn; formais; corpo} ->
           let vargs    = List.map  (interpreta_exp amb) args in
           let vformais = List.map2 (fun (n,t) v -> (n, t, Some v)) formais vargs
           in  interpreta_fun amb vformais corpo
        | _ -> failwith "interpreta_exp: expchamada"
      )
  | ExpNone -> T.ExpNone

and interpreta_cmd amb cmd =
  let open A in
  let open T in
  match cmd with
    Retorne exp ->
    (* Levantar uma exceção foi necessária pois, pela semântica do comando de   *)
    (* retorno, sempre que ele for encontrado em uma função, a computação       *)
    (* deve parar retornando o valor indicado, sem realizar os demais comandos. *)
    (match exp with
      (* Se a função não retornar nada, então retorne ExpVoid *)
      | None -> raise (Valor_de_retorno ExpNone)
      | Some e ->
        (* Avalia a expressão e retorne o resultado *)
        let e1 = interpreta_exp amb e in
        raise (Valor_de_retorno e1))
  | Se (teste, entao, senao) ->
      let teste1 = interpreta_exp amb teste in
      (match teste1 with
        | ExpBool (true,_) ->
        (* Interpreta cada comando do bloco 'então' *)
        List.iter (interpreta_cmd amb) entao
        | _ ->
          (* Interpreta cada comando do bloco 'senão', se houver *)
          (match senao with
            | None -> ()
            | Some bloco -> interpreta_cmd amb bloco))
  (* | CONDICAOElifElse comandos ->
        List.iter (interpreta_cmd amb ) comandos *)
  | Attrib (elem, exp) ->
      let resp = interpreta_exp amb exp in
        (match elem with
          | T.ExpVar (id,tipo) ->
           (try
              begin
                match (Amb.busca amb id) with
                  | Amb.EntVar (t, _) -> Amb.atualiza_var amb id tipo (Some resp)
                  | Amb.EntFun _      -> failwith "falha na atribuicao"
              end
            with Not_found ->
              let _ = Amb.insere_local amb id tipo None in
              Amb.atualiza_var amb id tipo (Some resp))
          | _ -> failwith "Falha CmdAtrib"
        )
  | Chamada exp -> ignore( interpreta_exp amb exp )
  | Leia exp ->
    (* Obtem os nomes e os tipos de cada um dos argumentos *)
    let nt = obtem_nome_tipo_var exp in
    let leia_var (nome,tipo) =
     let _ =
       (try
          begin
            match (Amb.busca amb nome) with
              | Amb.EntVar (_,_) -> ()
              | Amb.EntFun _     -> failwith "falha no input"
          end
        with Not_found ->
          let _ = Amb.insere_local amb nome tipo None in ()
        )
      in
      let valor =
       (match tipo with
          | TipoInteiro  -> T.ExpInt  (read_int   ()   , tipo)
          | TipoCaractere   -> T.ExpString (read_line  ()   , tipo)
          | TipoFloat     -> T.ExpFloat (read_float ()   , tipo)
          | _        -> failwith "Fail input")
      in  Amb.atualiza_var amb nome tipo (Some valor)
    in leia_var nt
  | Escreva exp ->
    let resp = interpreta_exp amb exp in
      (match resp with
        | T.ExpInt   (n,_) -> print_int    n
        | T.ExpFloat (n,_) -> print_float  n
        | T.ExpString (n,_) -> print_string n
        | T.ExpBool (b,_) ->
         let _ = print_string (if b then "true" else "false")
         in print_string " "
        | _ -> failwith "Fail print"
      )
  | Enquanto (cond, cmds) ->
        let rec laco cond cmds =
          let condResp = interpreta_exp amb cond in
                (match condResp with
                  | ExpBool (true,_) ->
                      (* Interpreta cada comando do bloco 'então' *)
                      let _ = List.iter (interpreta_cmd amb) cmds in
                        laco cond cmds
                  | _ -> ())
        in laco cond cmds
  | Para (idt, int_de ,int_ate, bloco) ->
    let (elem1,tipo) = obtem_nome_tipo_var idt in
    let rec executa_para amb int_de int_ate bloco elem1 tipo =
           if (int_de) <= (int_ate)
           then begin
                   (*Executa o bloco de código: *)
                   List.iter (interpreta_cmd amb) bloco;
                   (*Atualiza o valor da variavel: *)
                   Amb.atualiza_var amb elem1 tipo (Some ( ExpInt( (int_de + 1 ),TipoInteiro) ) );
                   (*Chamada recursiva:*)
                   executa_para amb (int_de + 1) int_ate bloco elem1 tipo;
                end in
    executa_para amb (pega_int int_de) (pega_int int_ate) bloco elem1 tipo

and interpreta_fun amb fn_formais fn_corpo =
  let open A in
 (* Estende o ambiente global, adicionando um ambiente local *)
  let ambfn = Amb.novo_escopo amb in
  (* Associa os argumento
  s aos parâmetros e insere no novo ambiente *)
  let insere_parametro (n,t,v) = Amb.insere_param ambfn n t v in
  let _ = List.iter insere_parametro fn_formais in
      (* Interpreta cada comando presente no corpo da função usando o novo *)
      (* ambiente                                                          *)
      try
        let _ = List.iter (interpreta_cmd ambfn) fn_corpo in T.ExpNone
      with
        Valor_de_retorno expret -> expret

let insere_declaracao_fun amb dec =
  let open A in
    match dec with
      | FuncDecl {fn_nome; fn_tiporet; fn_formais; fn_corpo} ->
        let nome = fst fn_nome in
        let formais = List.map (fun (n,t) -> ((fst n), t)) fn_formais in
        Amb.insere_fun amb nome formais fn_tiporet fn_corpo
      | _ -> failwith "Erro de declaacao de funcao"


let fn_predefs = let open A in [
    ("inputi", [("x", TipoInteiro  )], TipoVoid, []);
    ("inputf", [("x", TipoFloat     )], TipoVoid, []);
    ("inputs", [("x", TipoCaractere   )], TipoVoid, []);

]

(* insere as funções pré definidas no ambiente global *)
let declara_predefinidas amb =
  List.iter (fun (n,ps,tr,c) -> Amb.insere_fun amb n ps tr c) fn_predefs

let interprete ast =
  let open Amb in
  let amb_global = Amb.novo_amb [] in
  let _ = declara_predefinidas amb_global in
  let A.Prog instr = ast in
    let decs_funs = List.filter (fun x ->
    (match x with
    | A.FuncDecl _ -> true
    |             _ -> false)) instr in
    let _ = List.iter (insere_declaracao_fun amb_global) decs_funs in
      (try begin
        (match (Amb.busca amb_global "main") with
            | Amb.EntFun { tipo_fn ; formais ; corpo } ->
              let vformais = List.map (fun (n,t) -> (n, t, None)) formais in
              let _        = interpreta_fun amb_global vformais corpo in ()
            | _ -> failwith "variavel declarada como 'main'")
       end with Not_found -> failwith "Funcao main nao declarada ")


