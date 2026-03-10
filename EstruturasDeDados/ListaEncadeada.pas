(* Insere elementos linearmente *)
(* Pode ter valores inseridos na cabeça, cauda ou meio *)
(* Não é necessário remanejar itens após uma inserção no meio *)
(* Inserção na cabeça: O(1) *)
(* Inserção na cauda: O(n) *)
(* Inserção no meio: médio caso N/2-1 *)
program ListaEncadeada;

(* Definição de tipo para Lista encadeada *)
type
    ponteiro = record
            info : integer;
            prox : ^ponteiro;
        end;
    Lista = ^ponteiro;

var
    l : Lista;

(* Procedimento para criar lista *)
(* Utiliza nil como ponto de parada *)
procedure criar(var l : Lista);
begin
    l := nil;
end;

(* Procedimento para inserir elemento no início da lista *)
(* Insere informação logo no início *)
procedure inserir_cabeca(var l : Lista; info : integer);
var aux : Lista;
begin
    new(aux);

    aux^.info := info;
    aux^.prox := l;

    l := aux;
end;

(* Procedimento para inserir elemento no fim da lista *)
(* Insere informação ao final da lista *)
procedure inserir(var l : Lista; info : integer);

begin
    if l = nil then
    begin
        new(l);
        l^.info := info;
        l^.prox := nil;
    end
    else
    begin
        inserir(l^.prox, info);
    end;
end;

(* Procedimento para remover elemento desejado *)
(* No melhor caso o elemento está no início, no pior é necessário
   percorrer toda a lista para remover *)
procedure remover(var l : Lista; info : integer);

var
    aux : Lista;

begin
    if l = nil then
        exit

    else
    begin
        if l^.info = info then
        begin
            aux := l;
            l := l^.prox;
            dispose(aux);
        end
        else
        begin
            remover(l^.prox, info);
        end;
    end;
end;

(* Função para imprimir lista encadeada *)
procedure imprimir(l : Lista);
begin
    if l = nil then
        writeln

    else
    begin    
        write(l^.info);
        write(' ');

        imprimir(l^.prox);
    end;
end;

begin
    criar(l);

    inserir(l, 5);
    inserir(l, 2);
    inserir(l, 7);
    inserir(l, 9);
    inserir(l, 3);

    inserir_cabeca(l, 8);

    remover(l, 7);

    imprimir(l);
end.

