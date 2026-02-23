program MaximoMinimo3;
(* Melhor implementação para buscar máximo e mínimo *)
(* No melhor caso: 3n/2-2 *)
(* No pior caso: 3n/2-2 *)
const
    n = 10;

type
    vetor = array[0..n] of integer;

var
    a : vetor = (3, 1, 5, 10, 7, 8, 9, 12, 19, 0, 13);
    minimo, maximo : integer;

procedure MaxMin3(var a : vetor; var max, min : integer);

var
    i, FimDoAnel : integer;

begin
    if (n mod 2) <> 0 then
    begin
       a[n+1] := a[n];
       FimDoAnel := n; 
    end
    else
        FimDoAnel := n-1;

    if a[1] > a[2] then
    begin
       max := a[1];
       min := a[2]; 
    end
    else
        max := a[2];
        min := a[1];

    i := 3;

    while i <= FimDoAnel do
    begin
        if a[i] > a[i+1] then
        begin
           if a[i] > max then
               max := a[i];
            
           if a[i+1] < min then
               min := a[i+1];
        end
        else
        begin
            if a[i] < min then
                min := a[i];
            if a[i+1] > max then
                max := a[i+1];
        end;
        i := i + 2;
    end;
end;

begin
    MaxMin3(a, maximo, minimo);

    writeln('Máximo: ', maximo);
    writeln('Mínimo: ', minimo);
end.