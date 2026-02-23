program MaximoMinimo1;
(* Encontrar valores máximo e mínimo de um vetor *)
(* No melhor caso: 2(n-1) *)
(* No pior caso: 2(n-1) *)
const
    n = 10;

type
    vetor = array[1..10] of integer;

var
    a : vetor = (3, 1, 5, 10, 7, 8, 9, 12, 19, 0);
    maximo, minimo : integer;

procedure MaxMin1(var a : vetor; var max, min : integer);

var
    i : integer;

begin
    max := a[1];
    min := a[1];

    for i := 2 to n do
    begin
        if a[i] > max then
            max := a[i];
        
        if a[i] < min then
            min := a[i];
    end;
end;

begin
    MaxMin1(a, maximo, minimo);

    writeln('Máximo: ', maximo);
    writeln('Mínimo: ', minimo);
end.