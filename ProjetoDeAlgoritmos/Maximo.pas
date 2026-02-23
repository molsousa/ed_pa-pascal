program Maximo;
(* Algoritmo para buscar o valor máximo de um vetor *)
(* Complexidade O(n) *)
const
    n = 10;

type
    vetor = array[1..n] of integer;

var
    a : vetor = (3, 1, 5, 10, 7, 8, 9, 12, 19, 0);
    valor_maximo : integer;

function max(var a : vetor) : integer;

var
    i, temp : integer;

begin
    temp := a[1];

    for i := 2 to n do
        if temp < a[i] then
            temp := a[i];

    max := temp;
end;

begin
    valor_maximo := max(a);

    writeln(valor_maximo);
end.