(* Implementação de fila usando lista encadeada *)
(* Um novo elemento é sempre inserido ao final da fila *)
(* A remoção sempre ocorre com o primeiro elemento *)
(* Complexidade:
    Inserir: O(1)
    Remover: O(1)
*)
(* Para a implementação de fila, é utilizado dois ponteiros para não
   precisar percorrer a lista inteira para inserção *)
program FilaDinamica;

(* Definição de fila dinâmica *)
type
    lista = record
            info : integer;
            prox : ^lista;
        end;
    DSFila = record
            primeiro : ^lista;
            ultimo : ^lista;
        end;
    Fila = ^DSFila;
    No = ^lista;

var
    f : Fila;

(* Procedimento para criar nova fila *)
(* Aloca fila e atribui nil para primeiro e último *)
procedure criar(var f : Fila);
begin
    new(f);

    f^.primeiro := nil;
    f^.ultimo := nil;
end;

(* Função para verificar se uma fila é vazia *)
(* Retorna true se vazia *)
function vazia(f : Fila) : boolean;
begin
    vazia := (f^.primeiro = nil);
end;

(* Procedimento para enfileirar novo elemento *)
(* Elemento inserido sempre no final da lista de elementos *)
procedure queue(f : Fila; info : integer);

var
    x : No;

begin
    new(x);

    x^.info := info;
    x^.prox := nil;

    if vazia(f) then
        f^.primeiro := x
    
    else
        f^.ultimo^.prox := x;

    f^.ultimo := x;
end;

(* Procedimento para defileirar elemento *)
(* Remove o primeiro elemento inserido na fila *)
procedure dequeue(f : Fila);

var
    x : No;

begin
    if not(vazia(f)) then
    begin
        x := f^.primeiro;

        if (f^.primeiro = f^.ultimo) then
            f^.ultimo := nil;

        f^.primeiro := f^.primeiro^.prox;
        dispose(x);
    end;
end;

(* Procedimento para chamar procedimento para imprimir a lista contida na estrutura de fila *)
procedure print(f : Fila);
    (* Procedimento para imprimir lista encadeada *)
    procedure print_aux(l : No);
    begin
        if l = nil then
            writeln('nil')

        else
        begin
            write('|',l^.info, '|->');
            print_aux(l^.prox);
        end;
    end;
begin
    print_aux(f^.primeiro);
end;

begin
    criar(f);

    queue(f, 5);
    queue(f, 12);
    queue(f, 7);
    queue(f, 11);
    queue(f, 2);
    queue(f, 9);
    queue(f, 17);
    queue(f, 4);

    print(f);

    dequeue(f);
    dequeue(f);
    dequeue(f);
    dequeue(f);
    dequeue(f);
    dequeue(f);
    dequeue(f);
    dequeue(f);

    print(f);

end.
