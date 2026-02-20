program EncontrarMaximo;

procedure maximo(a, b : integer; var x: integer);
begin
    if a > b then
        x := a
    else
        x := b;
end;

var
    x : integer;

begin
    maximo(10, 6, x);
    writeln(x);
end.