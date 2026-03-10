(*
 * Árvore binária.
 * Possui um ponteiro pra esquerda e direita para
   distribuir as informações menores e maiores respectivamente.
 * Caso a árvore binária for completa, a busca tem uma complexidade de
   O(log n).
 * Caso a árvore binária tenha valores inseridos em ordem crescente ou
   decrescente a busca tem complexidade O(n). No pior dos casos vira uma
   lista encadeada.
*)

program ArvoreBinaria;

type
    noAB = record
        info : integer;
        esq : ^noAB;
        dir : ^noAB;
    end;
    Arvore = ^noAB;

var
    r : Arvore;

(* Procedimento para criar árvore binária *)
(* Atribui nil como ponto de parada *)
procedure criar(var r : Arvore);
begin
    r := nil;
end;

(* Procedimento para inserir informação *)
(* Caso a informação seja menor que a informação no nó atual
   cai para a esquerda.
 * Caso a informação seja maior que a informação do nó atual
   cai para a direita.
 * Insere sempre nova informação como folha.
 *)
procedure inserir(var r : Arvore; info : integer);
begin
    if r = nil then
    begin
       new(r);
       r^.info := info;
       r^.esq := nil;
       r^.dir := nil;
    end

    else
    begin
        if r^.info > info then
            inserir(r^.esq, info)

        else
            inserir(r^.dir, info);
    end;
end;

(* Função para buscar valor máximo *)
function maximo(r : Arvore) : integer;

var
    aux : Arvore;

begin
    aux := r;

    while aux^.dir <> nil do
        aux := aux^.dir;

    maximo := aux^.info;
end;

(* Função para buscar valor mínimo *)
function minimo(r : Arvore) : integer;

var
    aux : Arvore;

begin
    aux := r;

    while aux^.esq <> nil do
        aux := aux^.esq;

    minimo := aux^.info;
end;

(* Procedimento para remover informação *)
(* Caso o elemento encontrado seja folha, libera e atribui a nil*)
(* Caso o elemento seja nó interno, busca o valor na folha recursivamente
    e atribui ao nó interno atual, após, busca o elemento na folha para remover. *)
(* Caso não encontre o elemento buscado, finaliza a recursão *)
procedure remover(var r : Arvore; info : integer);

begin
    if r = nil then
        exit

    else
    begin
        if r^.info > info then
            remover(r^.esq, info)

        else if r^.info < info then
            remover(r^.dir, info)

        else
        begin
            if (r^.esq = nil) and (r^.dir = nil) then
            begin
                dispose(r);
                r := nil;
            end

            else if r^.esq = nil then
            begin
                r^.info := minimo(r^.dir);
                remover(r^.dir, r^.info);
            end
            else
            begin
                r^.info := maximo(r^.esq);
                remover(r^.esq, r^.info);
            end;
        end;
    end;
end;

(* Procedimento para imprimir árvore em pre-order *)
(* Imprime a raiz, imprime cada um dos elementos na esquerda *)
(* Na volta, cai pra direita e imprime os elementos da direita *)
procedure imprimir(r : Arvore);
begin
    if r = nil then

    else
    begin
        writeln(r^.info);
        imprimir(r^.esq);
        imprimir(r^.dir);
    end;
end;

(* Procedimento para imprimir por níveis *)
procedure imprimirNiveis(r : Arvore);
type
    vetArvore = array[0..1000] of Arvore;

var
    atual : Arvore;
    vetor : vetArvore;
    i, fim, inicio, nivel : int64;

begin
    if r <> nil then
    begin
        fim := 0;
        inicio := 0;

        vetor[fim] := r;
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

                if (i < nivel) then
                    write(' ');
            end;
            writeln('>');
        end;
    end;
end;

begin
    criar(r);

    inserir(r, 11);
    inserir(r, 5);
    inserir(r, 24);
    inserir(r, 2);
    inserir(r, 6);
    inserir(r, 18);
    inserir(r, 9);
    inserir(r, 34);

    imprimir(r);

    imprimirNiveis(r);

    writeln;

    remover(r, 11);

    imprimirNiveis(r);
end.
