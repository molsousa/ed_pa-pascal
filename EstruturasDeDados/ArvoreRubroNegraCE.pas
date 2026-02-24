program ArvoreRubroNegra;


type
    cores = (VERMELHO, PRETO);

type
    noRN = record
        info : integer;
        cor : cores;
        esq : ^noRN;
        dir : ^noRN;
    end;

type
    DSRubroNegra = ^noRN;
    arvoreRN = ^DSRubroNegra;

var
    r : arvoreRN;

function criar() : arvoreRN;
begin
    new(criar);

    criar^ := nil;
end;

function vazia(r : DSRubroNegra) : boolean;
begin
    vazia := (r = nil);
end;

function cor(r : DSRubroNegra) : cores;
begin
    if vazia(r) then
        cor := PRETO
    else
        cor := r^.cor;
end;

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

function rotacionar_esquerda(r : DSRubroNegra) : DSRubroNegra;
begin
    rotacionar_esquerda := r^.dir;
    r^.dir := rotacionar_esquerda^.esq;
    rotacionar_esquerda^.esq := r;

    rotacionar_esquerda^.cor := r^.cor;
    r^.cor := VERMELHO;
end;

function rotacionar_direita(r : DSRubroNegra) : DSRubroNegra;
begin
    rotacionar_direita := r^.esq;
    r^.esq := rotacionar_direita^.dir;
    rotacionar_direita^.dir := r;

    rotacionar_direita^.cor := r^.cor;
    r^.cor := VERMELHO;
end;

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

procedure imprimir(r : arvoreRN);
begin
    imprimir_aux(r^);
end;

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

    imprimir(r);

    imprimirNiveis(r);
end.
        