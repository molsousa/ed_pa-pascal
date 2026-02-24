(* Árvore Rubro Negra caída à esquerda <3 *)
(* Essa implementação segue as mesmas regras tradicionais, 
    com um diferencial que todo nó vermelho cai à esquerda 
    e nunca à direita *)
(* Nessa implementação, a complexidade das operação é mantida *)

(* Regras *)
(*  
    Todo nó inserido é inicialmente vermelho
    A raiz é sempre preta
    Todo nó vermelho é filho esquerdo de um nó pai preto
    Todo nó vermelho possui dois filhos pretos ou nulos
    Todo caminho simples contém a mesma quantidade de nós pretos
*)
program ArvoreRubroNegra;

(* Enumeração para cores *)
type
    cores = (VERMELHO, PRETO);

(* Definição de registro para nó rubro negro *)
type
    noRN = record
        info : integer;
        cor : cores;
        esq : ^noRN;
        dir : ^noRN;
    end;

(* Definição de tipos *)
(* Manipulação de nó rubro negro *)
(* Tipo para árvore rubro negra *)
type
    DSRubroNegra = ^noRN;
    arvoreRN = ^DSRubroNegra;

var
    r : arvoreRN;

(* Função para criar árvore *)
(* Cria nova árvore e atribui nil ao ponteiro armazenado *)
function criar() : arvoreRN;
begin
    new(criar);

    criar^ := nil;
end;

(* Função para verificar se um nó é vazio *)
(* Atribui true se vazio *)
function vazia(r : DSRubroNegra) : boolean;
begin
    vazia := (r = nil);
end;

(* Função de busca *)
(* Atribui resultado booleano verdadeiro caso um elemento se encontrar na árvore *)
function busca(r : DSRubroNegra; info : integer) : boolean;
begin
    if r = nil then
        busca := false
    
    else if r^.info = info then
    begin
        busca := true;
        exit;
    end

    else if r^.info > info then
        busca := busca(r^.esq, info)

    else
        busca := busca(r^.dir, info);
end;    

(* Função para verificar cor do nó *)
(* Atribui PRETO se vazio e a cor atual caso contrário *)
function cor(r : DSRubroNegra) : cores;
begin
    if vazia(r) then
        cor := PRETO
    else
        cor := r^.cor;
end;

(* Procedimento para troca de cor *)
(* Aplica inversão de cores em determinados nós caso entrem nas condicionais *)
procedure troca_cor(r : DSRubroNegra);
begin
    if r^.cor = VERMELHO then
        r^.cor := PRETO
    else
        r^.cor := VERMELHO;

    if not vazia(r^.esq) then
    begin
        if (r^.esq^.cor = VERMELHO) then
            r^.esq^.cor := PRETO
        else
            r^.esq^.cor := VERMELHO;
    end;

    if not vazia(r^.dir) then
    begin
        if (r^.dir^.cor = VERMELHO) then
            r^.dir^.cor := PRETO
        else
            r^.dir^.cor := VERMELHO;
    end;
end;

(* Função para rotacionar nó à esquerda *)
(* Rotaciona raiz para a esquerda, subindo o nó destino à raiz *)
function rotacionar_esquerda(r : DSRubroNegra) : DSRubroNegra;
begin
    rotacionar_esquerda := r^.dir;
    r^.dir := rotacionar_esquerda^.esq;
    rotacionar_esquerda^.esq := r;

    rotacionar_esquerda^.cor := r^.cor;
    r^.cor := VERMELHO;
end;

(* Função para rotacionar nó à direita *)
(* Rotaciona raiz para a direita, subindo o nó destino à raiz *)
function rotacionar_direita(r : DSRubroNegra) : DSRubroNegra;
begin
    rotacionar_direita := r^.esq;
    r^.esq := rotacionar_direita^.dir;
    rotacionar_direita^.dir := r;

    rotacionar_direita^.cor := r^.cor;
    r^.cor := VERMELHO;
end;

(* Função para aplicar rotação dupla à esquerda *)
(* Efetua a troca de cor e aplica rotações, à direita e à esquerda *)
function mover_para_esquerda(r : DSRubroNegra) : DSRubroNegra;
begin
    troca_cor(r);

    if (cor(r^.dir^.esq) = VERMELHO) then
    begin
        r^.dir := rotacionar_direita(r^.dir);
        r := rotacionar_esquerda(r);
        troca_cor(r);
    end;

    mover_para_esquerda := r;
end;

(* Função para aplicar troca de cor e rotação a direita em nó *)
(* Efetua troca de cor e aplica rotação no nó raiz *)
function mover_para_direita(r : DSRubroNegra) : DSRubroNegra;
begin
    troca_cor(r);

    if (cor(r^.esq^.esq) = VERMELHO) then
    begin
        r := rotacionar_direita(r);
        troca_cor(r);
    end;

    mover_para_direita := r;
end;

(* Função para balancear árvore após remoção *)
(* Aplica balanceamento após remoção de determinado nó chave *)
function balancear(r : DSRubroNegra) : DSRubroNegra;
begin
    if (cor(r^.dir) = VERMELHO) then
        r := rotacionar_esquerda(r);

    if (not vazia(r^.esq) and (cor(r^.esq) = VERMELHO) and (cor(r^.esq^.esq) = VERMELHO)) then
        r := rotacionar_direita(r);

    if ((cor(r^.esq) = VERMELHO) and (cor(r^.dir) = VERMELHO)) then
        troca_cor(r);

    balancear := r;
end;

(* Função cauda para inserção de nó rubro negro *)
(* Se vazia insere um novo nó e aplica correções de cores no backtracking *)
function inserir_aux(r : DSRubroNegra; info : integer ) : DSRubroNegra;
begin
    if vazia(r) then
    begin
        new(r);

        r^.info := info;
        r^.esq := nil;
        r^.dir := nil;
        r^.cor := VERMELHO;

        inserir_aux := r;
        exit;
    end

    else if info < r^.info then
        r^.esq := inserir_aux(r^.esq, info)
    
    else if info > r^.info then
        r^.dir := inserir_aux(r^.dir, info);

    if (cor(r^.dir) = VERMELHO) and (cor(r^.esq) = PRETO) then
        r := rotacionar_esquerda(r);

    if (cor(r^.esq) = VERMELHO) and (cor(r^.esq^.esq) = VERMELHO) then
        r := rotacionar_direita(r);

    if (cor(r^.esq) = VERMELHO) and (cor(r^.dir) = VERMELHO) then
        troca_cor(r);

    inserir_aux := r;
end;

(* Procedimento para inserção de chave em árvore rubro negra *)
(* Chama função cauda e após verifica se o nó é raiz para mudança de cor *)
procedure inserir(r : arvoreRN; info : integer);

var aux : DSRubroNegra;

begin
    r^ := inserir_aux(r^, info);

    if not vazia(r^) then
    begin
        aux := r^;
        aux^.cor := PRETO;
        r^ := aux;
    end;
end;

(* Função para remover nó menor *)
(* Aplica rotações e troca de cores se necessário e remove nó menor *)
function remover_no_menor(r : DSRubroNegra) : DSRubroNegra;
begin
    if r^.esq = nil then
    begin
        dispose(r);
        remover_no_menor := nil;
        exit;
    end;

    if (cor(r^.esq) = PRETO) and (cor(r^.esq^.esq) = PRETO) then
        r := mover_para_esquerda(r);

    r^.esq := remover_no_menor(r^.esq);

    remover_no_menor := balancear(r);
end;

(* Função para buscar menor nó *)
(* Percorre até encontrar o nó mais a esquerda *)
function procurar_menor(r : DSRubroNegra) : DSRubroNegra;

begin
    procurar_menor := r;

    while procurar_menor^.esq <> nil do
        procurar_menor := procurar_menor^.esq;
end;

(* Função em cauda para remoção de nó rubro negro *)
(* Aplica rotações e troca de cores após remoção para balancear árvore *)
function remover_aux(r : DSRubroNegra; info : integer) : DSRubroNegra;

var
    aux : DSRubroNegra;

begin
    if info < r^.info then
    begin
        if ((cor(r^.esq) = PRETO) and (cor(r^.esq^.esq) = PRETO)) then
            r := mover_para_esquerda(r);
        
        r^.esq := remover_aux(r^.esq, info);
    end
    else
    begin
        if (cor(r^.esq) = VERMELHO) then
            r := rotacionar_direita(r);

        if (info = r^.info) and (vazia(r^.dir)) then
        begin
            dispose(r);
            remover_aux := nil;
            exit;
        end;

        if (cor(r^.dir) = PRETO) and (cor(r^.dir^.esq) = PRETO) then
            r := mover_para_direita(r);

        if info = r^.info then
        begin
            aux := procurar_menor(r^.dir);

            writeln(aux^.info);

            r^.info := aux^.info;
            r^.dir := remover_no_menor(r^.dir);
        end
        else
            r^.dir := remover_aux(r^.dir, info);
    end;
    remover_aux := balancear(r);
end;

(* Procedimento para remoção de chave em árvore rubro negra *)
(* Após remoção, fixa a raiz como nó PRETO *)
procedure remover(r : arvoreRN; info : integer);

var aux : DSRubroNegra;

begin
    if (busca(r^, info) = false) then
        exit;

    r^ := remover_aux(r^, info);

    if not vazia(r^) then
    begin
        aux := r^;
        aux^.cor := PRETO;
        r^ := aux;
    end;
end;

(* Procedimento cauda para impressão de rubro negra pre-order *)
procedure imprimir_aux(r : DSRubroNegra);
begin
    if r = nil then
        exit;

    write(r^.info, ' ');

    if r^.cor = VERMELHO then
        writeln(VERMELHO)
    
    else
        writeln(PRETO);

    imprimir_aux(r^.esq);
    imprimir_aux(r^.dir);
end;

(* Procedimento para impressão de rubro negra *)
procedure imprimir(r : arvoreRN);
begin
    imprimir_aux(r^);
end;

(* Procedimento para impressão por níveis de árvore rubro negra *)
procedure imprimirNiveis(r : arvoreRN);

var
    atual : DSRubroNegra;
    vetor : array[0..1000] of DSRubroNegra;
    i, fim, inicio, nivel : int64;

begin
    if r = nil then
        exit;

    fim := 0;
    inicio := 0;

    vetor[fim] := r^;
    fim := fim + 1;

    while fim > inicio do
    begin
        nivel := fim - inicio;

        write('<');

        for i := 1 to nivel do
        begin
            atual := vetor[inicio];
            inicio := inicio + 1;

            write(atual^.info);

            if (atual^.esq) <> nil then
            begin
                vetor[fim] := atual^.esq;
                fim := fim + 1;
            end;

            if (atual^.dir) <> nil then
            begin
                vetor[fim] := atual^.dir;
                fim := fim + 1;
            end;

            if i < nivel then
                write(' ');
        end;
        writeln('>');
    end;
end;

begin
    r := criar();

    inserir(r, 3);
    inserir(r, 2);
    inserir(r, 32);
    inserir(r, 6);
    inserir(r, 8);
    inserir(r, 27);
    inserir(r, 7);
    inserir(r, 4);
    inserir(r, 5);
    inserir(r, 24);
    inserir(r, 15);
    inserir(r, 18);
    inserir(r, 26);
    inserir(r, 10);
    inserir(r, 21);
    inserir(r, 12);
    inserir(r, 17);
    inserir(r, 1);
    inserir(r, 11);

    remover(r, 18);

    imprimir(r);

    imprimirNiveis(r);
end.
        