(* Implementação de pilha usando lista encadeada *)
(* Um novo elemento é sempre inserido na cabeça *)
(* O elemento removido é sempre o último inserido LIFO *)
(* Complexidade:
    Inserir: O(1)
    Remover: O(1)
*)
program PilhaDinamica;

(* Definição de pilha dinâmica *)
type
    lista = record
            info : integer;
            prox : ^lista;
        end;
    DSPilha = record
            topo : ^lista;
        end;
    Pilha = ^DSPilha;
    No = ^lista;

var
    p : Pilha;

(* Procedimento para criar pilha *)
(* Cria novo ponteiro e atribui nil para o topo *)
procedure criar(var p : Pilha);
begin
    new(p);

    p^.topo := nil;
end;

(* Função para verificar se uma pilha é vazia *)
(* Retorna true se vazia *)
function vazia(p : Pilha) : boolean;
begin
    vazia := (p^.topo = nil);
end;

(* Procedimento para empilhar novo elemento *)
(* Elemento inserido sempre no topo da lista de elementos *)
procedure push(p : Pilha; info : integer);

var 
    x : No;

begin
    new(x);

    x^.info := info;
    x^.prox := p^.topo;

    p^.topo := x;
end;

(* Procedimento para desempilhar elemento *)
(* Remove o último elemento inserido na pilha *)
procedure pop(p : Pilha);

var x : No;

begin
    if not(vazia(p)) then
    begin
        x := p^.topo;
        p^.topo := p^.topo^.prox;
        dispose(x);
    end;
end;

(* Procedimento para imprimir lista encadeada *)
procedure print_aux(l : No);
begin
    if l = nil then
        writeln('nil')

    else
    begin
        writeln('|', l^.info:2, '|');
        print_aux(l^.prox);
    end;
end;

(* Procedimento para chamar procedimento para imprimir a lista contida na estrutura de pilha *)
procedure print(p : Pilha);
begin
    print_aux(p^.topo);    
end;

begin
    criar(p);

    push(p, 5);
    push(p, 12);
    push(p, 7);
    push(p, 15);
    push(p, 0);
    push(p, 2);
    push(p, 1);

    print(p);
    writeln;

    pop(p);
    pop(p);
    pop(p);
    pop(p);
    pop(p);
    pop(p);
    pop(p);

    print(p);
end.
