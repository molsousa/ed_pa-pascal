program FilaDinamica;

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


procedure criar(var f : Fila);
begin
    new(f);

    f^.primeiro := nil;
    f^.ultimo := nil;
end;

function vazia(f : Fila) : boolean;
begin
    vazia := (f^.primeiro = nil);
end;

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

procedure print(f : Fila);
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
