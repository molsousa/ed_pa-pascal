program ArvoreBinaria;

type
    ponteiro = record
        info : integer;
        esq : ^ponteiro;
        dir : ^ponteiro;
    end;

type
    Arvore = ^ponteiro;

var
    r : Arvore;

function criar() : Arvore;
begin
    criar := nil;
end;

function inserir(r : Arvore; info : integer) : Arvore;
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
            r^.esq := inserir(r^.esq, info)

        else
            r^.dir := inserir(r^.dir, info);
    end;

    inserir := r;
end;

function maximo(r : Arvore) : integer;

var
    aux : Arvore;

begin
    aux := r;

    while aux^.dir <> nil do
        aux := aux^.dir;

    maximo := aux^.info;
end;

function minimo(r : Arvore) : integer;

var
    aux : Arvore;

begin
    aux := r;

    while aux^.esq <> nil do
        aux := aux^.esq;

    minimo := aux^.info;
end;

function remover(r : Arvore; info : integer) : Arvore;

begin
    if r = nil then
        remover := r

    else
    begin
        if r^.info > info then
            r^.esq := remover(r^.esq, info)

        else if r^.info < info then
            r^.dir := remover(r^.dir, info)

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
                r^.dir := remover(r^.dir, r^.info);
            end
            else
            begin
                r^.info := maximo(r^.esq);
                r^.esq := remover(r^.esq, r^.info);
            end;
        end;
    end;

    remover := r;
end;

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

begin
    r := criar();

    r := inserir(r, 11);
    r := inserir(r, 5);
    r := inserir(r, 24);
    r := inserir(r, 2);
    r := inserir(r, 6);
    r := inserir(r, 18);
    r := inserir(r, 9);
    r := inserir(r, 34);

    r := remover(r, 11);

    imprimir(r);
end.