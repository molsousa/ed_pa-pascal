program MaximoMinimo4;

const
    n = 10;

type
    vetor = array[1..n] of integer;

var
    a : vetor = (3, 1, 5, 10, 7, 8, 9, 12, 19, 0);
    maximo, minimo : integer;

procedure MaxMin4(lInf, lSup : integer; var max, min : integer);

var
    max1, max2, min1, min2, meio : integer;

begin
    if lSup - lInf <= 1 then
        if a[lInf] < a[lSup] then
        begin
            max := a[lSup];
            min := a[lInf];
        end
        else
        begin
            max := a[lInf];
            min := a[lSup];
        end
    else
    begin
        meio := Trunc((lInf + lSup)/2);
        MaxMin4(lInf, meio, max1, min1);
        MaxMin4(meio+1, lSup, max2, min2);

        if max1 > max2 then
            max := max1
        else
            max := max2;

        if min1 < min2 then
            min := min1
        else
            min := min2;
    end;
end;

begin
    MaxMin4(1, n, maximo, minimo);

    writeln(maximo);

    writeln(minimo);
end.