program ListaEncadeada;

type
    ponteiro = record
        info : integer;
        prox : ^ponteiro;
    end;

type
    Lista = ^ponteiro;

var
    l : Lista;

function criar() : Lista;
begin
    criar := nil;
end;

function inserir(l : Lista; info : integer) : Lista;

begin
    if l = nil then
    begin
        new(l);
        l^.info := info;
        l^.prox := nil;
    end
    else
    begin
        l^.prox := inserir(l^.prox, info);
    end;

    inserir := l;
end;

function remover(l : Lista; info : integer) : Lista;

var
    aux : Lista;

begin
    if l = nil then
        remover := l

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
            l^.prox := remover(l^.prox, info);
        end;
    end;

    remover := l;
end;

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
    l := criar();

    l := inserir(l, 5);
    l := inserir(l, 2);
    l := inserir(l, 7);
    l := inserir(l, 9);
    l := inserir(l, 3);

    l := remover(l, 7);

    imprimir(l);
end.

