program Ordena;

const
    n = 10;

type
    vetor = array[1..n] of integer;

var
    a : vetor = (3, 1, 5, 10, 7, 8, 9, 12, 19, 0);
    i : integer;


procedure Ordenar(var a : vetor);

var
    i, j, min, x : integer;

begin
    for i := 1 to n-1 do
    begin
        min := i;

        for j := i+1 to n do
            if a[j] < a[min] then
                min := j;

        x := a[min];
        a[min] := a[i];
        a[i] := x;
    end;
end;

begin
    Ordenar(a);

    for i := 1 to n do
        write(a[i], ' ');
end.