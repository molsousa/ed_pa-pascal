program FormBhaskara;

uses math;

procedure bhaskara(a : float; b : float; c : float);
var
    delta, x1, x2 : float;

begin
    delta := (power(b, 2)) - 4 * a * c;
    delta := sqrt(delta);

    x1 := ((-b) + delta)/(2*a);
    x2 := ((-b) - delta)/(2*a);

    writeln('X1 = ', x1:0:4);
    writeln('X2 = ', x2:0:4);
end;

begin
    bhaskara(2, -12, 6);
end.