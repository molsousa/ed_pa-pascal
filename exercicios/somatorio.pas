program Somatorio;

function soma(a : integer):integer;

var
    total : integer;

begin
    total := 0;

    while a > 0 do
    begin
        total := total + a;
        a := a - 1;
    end;

    soma := total;
end;

function somaDois(a, b : integer) : integer;

begin
    somaDois := a + b;
end;

begin
    writeln(soma(100));
    writeln(somaDois(10, 5));
end.