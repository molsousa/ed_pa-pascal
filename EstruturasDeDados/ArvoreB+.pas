program ArvoreBMais;

const 
    ORDEM = 5;

type
    ponteiro = record
        chave : array[0..ORDEM-1] of integer;
        filhos : array[0..ORDEM] of ^ponteiro;
        num_chaves : integer;
        folha : boolean;
    end;

type
    BMais = ^ponteiro;

var
    r : BMais;

function criar() : BMais;
begin
    criar := nil;
end;

function vazia(r : BMais) : boolean;
begin
    vazia := (r = nil);
end;

function overflow(r : BMais) : boolean;
begin
    overflow := (r^.num_chaves = ORDEM);
end;

procedure conta_nos_aux(r : BMais; var total : integer);

var
    i : integer;

begin
    if vazia(r) then

    else
    begin
        total := total + 1;

        for i := 0 to r^.num_chaves do
        begin
            conta_nos_aux(r^.filhos[i], total);
        end;
    end;
end;

function conta_nos(r : BMais) : integer;

begin
    if vazia(r) then
    begin
        conta_nos := 0;
        exit;
    end;

    conta_nos_aux(r, conta_nos);
end;

procedure corrigir_intervalo(r : BMais);

var
    aux, nos_intervalo : array of BMais;
    i, j, k, fim, inicio : integer;
    atual, prox : BMais;

begin
    k := 0;
    fim := 0;
    inicio := 0;

    setlength(aux, conta_nos(r));
    setlength(nos_intervalo, conta_nos(r));

    aux[fim] := r;
    fim := fim + 1;

    while fim > inicio do
    begin
        atual := aux[inicio];
        inicio := inicio +1;

        if atual^.folha then
        begin
            nos_intervalo[k] := atual;
            k := k + 1;
        end;

        for j := 0 to atual^.num_chaves do
        begin
            if (atual^.filhos[j] <> nil) then
            begin
                aux[fim] := atual^.filhos[j];
                fim := fim + 1;
            end;
        end;
    end;

    for i := 0 to k-2 do
    begin
        atual := nos_intervalo[i];
        prox := nos_intervalo[i+1];

        atual^.filhos[ORDEM] := prox;
    end;
end;

function split(r : BMais; var m : integer) : BMais;

var
    q, i : integer;
    y : BMais;

begin
    new(y);

    for i := 0 to ORDEM do
        y^.filhos[i] := nil;

    q := Trunc(r^.num_chaves / 2);
    m := r^.chave[q];

    if r^.folha then
    begin
       y^.num_chaves := (r^.num_chaves - q);

       y^.folha := true;
       r^.num_chaves := q;

       for i := 0 to y^.num_chaves-1 do
        begin
            y^.chave[i] := r^.chave[q+i];
        end;
    end
    else
    begin
        y^.filhos[0] := r^.filhos[q+1];

        y^.num_chaves := (r^.num_chaves - q - 1);

        y^.folha := false;
        r^.num_chaves := q;

        for i := 0 to y^.num_chaves-1 do
        begin
            y^.chave[i] := r^.chave[q+i+1];
            y^.filhos[i+1] := r^.filhos[q+i+2];
        end;
    end;

    split := y;
end;

procedure adicionar_direita(r : BMais; pos : integer; k : integer; p : BMais);

var
    i : integer;

begin
    for i := (r^.num_chaves) downto pos do
    begin
        r^.chave[i] := r^.chave[i-1];
        r^.filhos[i+1] := r^.filhos[i];
    end;

    r^.chave[pos] := k;
    r^.filhos[pos+1] := p;
    r^.num_chaves := r^.num_chaves + 1; 
end;

function busca_pos(r : BMais; chave : integer; var pos : integer) : boolean;

var
    i : integer;

begin
    for i := 0 to (r^.num_chaves) do
    begin
        pos := i;
        if r^.chave[i] = chave then
        begin
            busca_pos := true;
            exit;
        end
        
        else if chave < r^.chave[i] then
        begin
            break;
        end;
    end;

    busca_pos := false;
end;

procedure inserir_aux(r : BMais; chave : integer);

var
    pos, m : integer;
    p : BMais;

begin
    if not(busca_pos(r, chave, pos)) then
    begin
        if r^.folha then
            adicionar_direita(r, pos, chave, nil)

        else
        begin
            inserir_aux(r^.filhos[pos], chave);

            if (overflow(r^.filhos[pos])) then
            begin
                p := split(r^.filhos[pos], m);
                adicionar_direita(r, pos, m, p);
            end;
        end;
    end;
end;

function criaPagina(chave : integer; folha : boolean; num_chaves : integer) : BMais;

var
    i : integer;
    r : BMais;

begin
    new(r);

    r^.chave[0] := chave;
    r^.num_chaves := num_chaves;
    r^.folha := folha;
    
    for i := 0 to ORDEM do
    begin
        r^.filhos[i] := nil; 
    end;

    criaPagina := r;
end;

function inserir(r : BMais; chave : integer) : BMais;

var
    x, nova_raiz : BMais;
    i, m : integer;

begin
    if vazia(r) then
    begin
       inserir := criaPagina(chave, true, 1);
    end
    else
    begin
        inserir_aux(r, chave);

        if overflow(r) then
        begin
            x := split(r, m);
            nova_raiz := criaPagina(m, false, 1);

            nova_raiz^.filhos[0] := r;
            nova_raiz^.filhos[1] := x;

            for i := Trunc((ORDEM/2)+1) to ORDEM-1 do
                r^.filhos[i] := nil;

            inserir := nova_raiz;
            exit;
        end;
        corrigir_intervalo(r);

        inserir := r;
    end;
end;

procedure ler_intervalo(r : BMais);

var
    i : integer;

begin
    while (r^.filhos[0] <> nil) do
        r := r^.filhos[0];

    while (not vazia(r)) do
    begin
        write('[');

        for i := 0 to r^.num_chaves-1 do
        begin
            write(r^.chave[i]);

            if i < r^.num_chaves-1 then
                write(',');
        end;

        write(']');

        r := r^.filhos[ORDEM];
    end;

    writeln;
end;

procedure imprimirNiveis(r : BMais);

var
    i, j, nivel, inicio, fim : integer;
    aux : array of BMais;
    atual : BMais;

begin
    if vazia(r) then
        writeln('nil')

    else
    begin
        fim := 0;
        inicio := 0;
        setlength(aux, conta_nos(r));

        aux[fim] := r;
        fim := fim + 1;

        while fim > inicio do
        begin
            nivel := fim - inicio;

            for i := 0 to nivel-1 do
            begin
                atual := aux[inicio];
                inicio := inicio + 1;

                write('[');

                for j := 0 to atual^.num_chaves-1 do
                begin
                    write(atual^.chave[j]);

                    if j < atual^.num_chaves-1 then
                        write(',');
                end;

                write(']');

                if (atual^.folha) then
                    write('->')
                else
                    write(' ');

                for j := 0 to atual^.num_chaves do
                begin
                    if (atual^.filhos[j] <> nil) then
                    begin
                        aux[fim] := atual^.filhos[j];
                        fim := fim + 1;
                    end;
                end;
            end;
            if (fim = inicio) and (not r^.folha) then
                writeln('NULL');

            writeln;
        end;
    end;
end;

begin
    r := criar();

    r := inserir(r, 9);
    r := inserir(r, 17);
    r := inserir(r, 11);
    r := inserir(r, 28);
    r := inserir(r, 12);
    r := inserir(r, 4);
    r := inserir(r, 8);
    r := inserir(r, 2);
    r := inserir(r, 7);
    r := inserir(r, 32);
    r := inserir(r, 19);
    r := inserir(r, 5);
    r := inserir(r, 24);
    r := inserir(r, 35);
    r := inserir(r, 1);
    r := inserir(r, 20);
    r := inserir(r, 27);
    r := inserir(r, 25);
    r := inserir(r, 45);
    r := inserir(r, 39);
    r := inserir(r, 23);
    r := inserir(r, 21);
    r := inserir(r, 22);

    imprimirNiveis(r);

    ler_intervalo(r);
end.