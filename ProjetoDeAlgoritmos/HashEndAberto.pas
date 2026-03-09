program HashEnderecamentoAberto;

const
    vazio = '!!!!!!!!';
    retirado = '********';
    M = 7;
    n = 10;

type
    Apontador = integer;
    TipoChave = packed array [1..n] of char;
    TipoPesos = array [1..n] of integer;
    TipoItem = record
                   Chave : TipoChave;
               end;
    Indice = 0..M-1;
    TipoDicionario = array[Indice] of TipoItem;

function h(Chave : TipoChave; p : TipoPesos) : Indice;
var i, soma : integer;
begin
    soma := 0;
    for i := 1 to n do
        soma := soma + ord(chave[i]) * p[i];

    h := soma mod M;
end;

procedure Inicializa(var T : TipoDicionario);
var i : integer;
begin
    for i := 0 to M-1 do
        T[i].Chave := Vazio;
end;

function Pesquisa(ch : TipoChave; var p : TipoPesos; var t : TipoDicionario) : Apontador;
var i, inicial : integer;
begin
    inicial := h(ch, p);
    i := 0;

    while (t[(inicial+i) mod M].chave <> Vazio) and (t[(inicial+i) mod M].chave <> ch) and (i < M) do
        i := i + 1;

    if t[(inicial + i) mod M].chave = ch then
        pesquisa := (inicial+i) mod M

    else
        pesquisa := M;
end;

procedure insere(x : TipoItem; var p : TipoPesos; var t : TipoDicionario);
var i, inicial : integer;
begin
    if pesquisa(x.chave, p, t) < M then
        writeln('Elemento repetido')

    else
    begin
        inicial := h(x.chave, p);
        i := 0;

        while (t[(inicial+i) mod M].chave <> Vazio) and (t[(inicial+i) mod M].chave <> Retirado) and (i < M) do
            i := i + 1;
        if i < M then
            t[(inicial+i) mod M] := x
        else
            writeln('Tabela cheia');
    end;
end;

procedure retira(ch : tipoChave; var p : tipoPesos; var t : TipoDicionario);
var i : integer;
begin
    i := pesquisa(ch, p, t);

    if (i < M) then
        t[i].chave := retirado
    else
        writeln('Registro não encontrado');
end;

begin

end.
