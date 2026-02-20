program CalculoFatorial;

var
    num, f : integer;

function fatorial(x : integer) : integer;
begin
    if x = 0 then
        fatorial := 1

    else
        fatorial := x * fatorial(x-1);
end;

begin
    write('Escreva um numero: ');
    readln(num);

    f := fatorial(num);

    writeln('O fatorial de ', num, ' eh ', f);
end.