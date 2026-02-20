program UsoPonteiro;

type
    pInteger = ^integer;

var
    a, b : pInteger;
    x, y : integer;

procedure troca(a, b : pInteger);
var
    temp : integer;

begin
    temp := a^;
    a^ := b^;
    b^ := temp;
end;

begin
    x := 5;
    y := 10;

    a := @x;
    b := @y;

    writeln('X: ', x);
    writeln('Y: ', y);
    writeln;

    troca(a, b);

    writeln('X: ', x);
    writeln('Y: ', y);
end.