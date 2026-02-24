program PilhaDinamica;

type
    lista = record
        info : integer;
        prox : ^lista;
    end;

type
    DSPilha = record
        topo : ^lista;
    end;

type
    Pilha = ^DSPilha;
    No = ^lista;

var
    p : Pilha;

function criar() : Pilha;
begin
    new(criar);

    criar^.topo := nil;
end;

function vazia(p : Pilha) : boolean;
begin
    vazia := (p^.topo = nil);
end;

procedure push(p : Pilha; info : integer);

var 
    x : No;

begin
    new(x);

    x^.info := info;
    x^.prox := p^.topo;

    p^.topo := x;
end;

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

procedure print(p : Pilha);
begin
    print_aux(p^.topo);    
end;

begin
    p := criar();

    push(p, 5);
    push(p, 12);
    push(p, 7);
    push(p, 15);
    push(p, 0);
    push(p, 2);
    push(p, 1);

    print(p);

    pop(p);
    pop(p);
    pop(p);
    pop(p);
    pop(p);
    pop(p);
    pop(p);

    print(p);
end.
