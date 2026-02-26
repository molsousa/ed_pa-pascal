program AlgoritmosOrdenacao;

const TAM = 29;

type 
    indice = 0..TAM;
    vetor = array[indice] of integer;

var
    a : vetor = (12, 7, 89, 34, 23, 56, 91, 44, 18, 3, 67, 72, 5, 48, 29, 81, 14, 
                95, 37, 62, 11, 76, 53, 9, 40, 85, 21, 98, 16, 70);
    i : integer;

procedure selectionSort(var a : vetor; n : integer);

var
    i, j, min : indice;
    x : integer;

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

procedure insertionSort(var a : vetor; n : integer);

var
    i, j : indice;
    x : integer;

begin
    for i := 2 to n do
    begin
        x := a[i];
        j := i-1;
        a[0] := x;

        while x < a[j] do
        begin
            a[j+1] := a[j];
            j := j-1;
        end;
        a[j+1] := x;
    end;
end;

begin
    insertionSort(a, TAM);

    for i := 0 to TAM do
        write(a[i], ' ');

    writeln;
end.