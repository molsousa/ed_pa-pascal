program soma;

var
    a, b, c : integer;
var
    s, area : double;
const
    PI = 3.14;

var
    idade: 18 ... 70;

begin
    readln(a, b, c);
    s := (a + b + c)/2.0;
    area := sqrt(s * (s - a) * (s - b) * (s - c));
    writeln(area);
end.