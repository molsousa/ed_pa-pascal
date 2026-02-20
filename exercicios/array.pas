program UsoArray;

type
    vetor = array[0..4] of integer;

var
    vet : vetor;
    i : integer;

begin
    for i := 0 to 4 do
        vet[i] := i+1;

    for i := 0 to 4 do
        writeln(vet[i]);
end.