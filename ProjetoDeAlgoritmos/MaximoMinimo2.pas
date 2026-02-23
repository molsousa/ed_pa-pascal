program MaximoMinimo2;
(* Versão melhorada de máximo e mínimo reduzindo o número de comparações *)
(* No melhor caso: n-1 *)
(* No pior caso: 2(n-1) *)
const
    n = 10;

type
    vetor = array[1..n] of integer;

var
    maximo, minimo : integer;
    a : vetor = (3, 1, 5, 10, 7, 8, 9, 12, 19, 0);

procedure MaxMin2(var a : vetor; var max, min : integer);

var
    i : integer;

begin
    max := a[1];
    min := a[1];

    for i := 2 to n do
        if a[i] > max then
            max := a[i]
        else if a[i] < min then
            min := a[i];
end;

begin
    MaxMin2(a, maximo, minimo);

    writeln('Máximo: ', maximo);
    writeln('Mínimo: ', minimo);
end.