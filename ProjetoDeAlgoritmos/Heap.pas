program HeapSort;

function max(var a : vetor) : integer;
begin
    max := a[1];
end;

procedure refaz(esq, dir : integer; var a : vetor);
label 999;

var
    i, j, x : integer

begin
    i := esq;
    j := 2 * i;
    x := a[1];

    while j <= dir do
    begin
        if j < dir then
            if a[j] < a[j+1] then
                j := j + 1;
        
        if x >= a[j] then
            goto 999;

        a[i] := a[j];
        i := j;
        j := 2 * 1;
    end;
    999 : a[i] := x;
end;

procedure constroi(var a : vetor; var n : integer);

var
    esq : integer;

begin
    esq := Trunc(n / 2) + 1;

    while esq > 1 do
    begin
        esq := esq - 1;
        refaz(esq, n, a);
    end;
end;

function retiraMax(var a : vetor; var n : integer) : integer;
begin
    if n >= 1 then
    begin
        retiraMax := a[1];
        a[1] := a[n];
        n := n - 1;
        refaz(1, n, a);
    end;
end;

procedure aumentaChave(i, chave : integer; var a : vetor);

var
    k, x : integer;

begin
    if chave >= a[i] then
    begin
        a[i] := chave;

        while (i > 1) and (a[Trunc(i/2)] < a[i]) do
    end;
end;