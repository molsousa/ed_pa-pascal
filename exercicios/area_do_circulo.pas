program AreaDoCirculo;

uses math;

const
    PI = 3.14159;

var
    raio, area : real;

begin
    readln(raio);
    {area := (raio*raio) * PI;}
    area := power(raio, 2) * PI;
    writeln('A=',area:0:4);
end.