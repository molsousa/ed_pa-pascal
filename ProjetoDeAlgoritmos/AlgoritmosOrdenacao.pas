program AlgoritmosOrdenacao;

const TAM = 29;

type 
    indice = 0..TAM;
    vetor = array[indice] of integer;

var
    a : vetor = (0, 7, 89, 34, 23, 56, 91, 44, 18, 3, 67, 72, 5, 48, 29, 81, 14, 
                95, 37, 62, 11, 76, 53, 9, 40, 85, 21, 98, 16, 70);
    i : integer;

(* Ordenação por seleção *)
(* Seleciona o menor elemento do vetor e o move ao início *)
(* O algoritmo é instável pois troca valores iguais *)
(*
 * Complexidade:
 *      Pior caso: O(n²)
 *      Caso médio: O(n²)
 *      Melhor caso: O(n²)
*)
procedure selectionSort(var a : vetor; n : integer);

var
    i, j, min : indice;
    x : integer;

begin
    for i := 2 to n-1 do
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

(* Ordenção por inserção *)
(* Insere os elementos na posição correta em relação aos antecessores *)
(* Em caso de uso do insertionSort, a primeira posição do vetor é usada como sentinela *)
(* O algoritmo é estável *)
(*
 * Complexidade:
 *      Pior caso: O(n²)
 *      Médio caso: O(n²)
 *      Melhor caso: O(n)
*)
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

(* Ordenação shell, mais eficiente que os demais *)
(* Compara elementos separados por intervalos (h) *)
(* Algoritmo mais rápido de complexidade quadrática *)
(* O algoritmo não é estável, portanto pode alterar a ordem de elementos repetidos *)
(*
 * Complexidade:
 *      Pior caso: O(n²)
 *      Caso médio: O(n log n)
 *      Melhor caso: O(n log n)
*)
procedure shellSort(var a : vetor; n : integer);
label 999;
var
    i, j, h : integer;
    x : integer;

begin
    h := 1;

    repeat h := 3 * h + 1 until h >= n;
    repeat
        h := Trunc(h / 3);

        for i := h + 1 to n do
        begin
            x := a[i];
            j := i;

            while a[j - h] > x do
            begin
                a[j] := a[j-h];
                j := j-h;

                if j <= h then
                    goto 999;
            end;
            999: a[j] := x;
        end;
    until h = 1;
end;

begin
    shellSort(a, TAM);

    for i := 1 to TAM do
        write(a[i], ' ');

    writeln;
end.
