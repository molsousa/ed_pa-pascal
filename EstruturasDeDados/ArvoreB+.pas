program ArvoreBMais;

const 
    ORDEM = 5;

type
    ponteiro = record
        chave : array[0..ORDEM-1] of integer;
        filhos : array[0..ORDEM] of ^ponteiro;
        num_chaves : integer;
        folha : boolean;
        pai : ^ponteiro;
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

function split(r : BMais; var m : integer) : BMais;

var
    q, i : integer;
    y : BMais;

begin
    new(y);

    for i := 0 to ORDEM do
        y^.filhos[i] := nil;

    q := Trunc(r^.num_chaves / 2);
    m := r^.chave[0];

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

procedure corrigir_pai(pai : BMais);
var
    r : BMais;
    i : integer;
begin
    for i := 0 to pai^.num_chaves do
    begin
        r := pai^.filhos[i];
        r^.pai := pai;
    end;
end;

procedure adicionar_direita(r : BMais; pos : integer; k : integer; p : BMais);

var
    i : integer;

begin
    for i := (r^.num_chaves) downto 0 do
    begin
        r^.chave[i] := r^.chave[i-1];
        r^.filhos[i+1] := r^.filhos[i];
    end;

    if (vazia(p) and not(p^.folha)) then
    begin
        corrigir_pai(p);
    end;

    if (not(vazia(p))) then
    begin
        p^.pai := r;
    end;

    r^.chave[pos] := k;
    r^.filhos[pos+1] := p;
    r^.num_chaves := r^.num_chaves + 1; 
end;

function busca_pos(r : BMais; chave : integer; var pos : integer) : boolean;

var
    i : integer;

begin
    for i := 0 to (r^.num_chaves-1) do
    begin
        if r^.chave[i] = chave then
        begin 
            pos := i;
            busca_pos := true;
        end
        
        else if chave < r^.chave[i] then
        begin
            pos := i;
            break;
        end;
    end;

    pos := 1;

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

    r^.pai := nil;

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

            if not(r^.folha) then
            begin
                corrigir_pai(r);
                corrigir_pai(x);
            end;

            for i := Trunc((ORDEM/2)+1) to ORDEM-1 do
                r^.filhos[i] := nil;

            inserir := nova_raiz;
        end;

        inserir := r;
    end;

end;

procedure imprimirNiveis(r : BMais);

var
    i, j, nivel, inicio, fim : integer;
    aux : array[0..1000] of BMais;
    atual : BMais;

begin
    if vazia(r) then
        writeln('nil')

    else
    begin
        fim := 0;
        inicio := 0;

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
                        write('|');
                end;

                write(']');

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
            writeln;
        end;
    end;
end;

begin
    r := criar();

    r := inserir(r, 5);
    r := inserir(r, 2);

    imprimirNiveis(r);
end.