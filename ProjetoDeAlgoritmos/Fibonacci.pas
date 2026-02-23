program Fibonacci;

function FibonacciRecursivo(n : integer) : integer;
begin
    if n < 2 then
        FibonacciRecursivo := n
    else
        FibonacciRecursivo := FibonacciRecursivo(n-1) + FibonacciRecursivo(n-2);
end;

function FibonacciIterativo(n : integer) : integer;

var
    i, k, f : integer;

begin
    i := 1;
    f := 0;

    for k := 1 to n do
    begin
        f := i + f;
        i := f - i;
    end;

    FibonacciIterativo := f;
end;

begin
    writeln(FibonacciRecursivo(10));

    writeln(FibonacciIterativo(10));
end.