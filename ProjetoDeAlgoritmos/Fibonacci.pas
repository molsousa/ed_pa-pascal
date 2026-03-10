(*
 * Algoritmo Fibonacci - O próximo valor é a soma dos dois valores anteriores
 * 0, 1, 1, 2, 3, 5, 8, 13, 21...
 * Nesse programa fora apresentado duas implementações, iterativo e recursivo.
 *)
program Fibonacci;

(* Função para calcular fibonacci recursivo *)
(* Cria uma pilha de funções muito grande conforme o valor de n cresce *)
(* Recomendável para números de N pequenos pela simplicidade na implementação *)
(* Inviável para números grandes *)
function FibonacciRecursivo(n : integer) : integer;
begin
    if n < 2 then
        FibonacciRecursivo := n
    else
        FibonacciRecursivo := FibonacciRecursivo(n-1) + FibonacciRecursivo(n-2);
end;

(* Função para calcular fibonacci iterativo *)
(* Versão recomendada para valores grandes de N *)
(* Não abre novas funções, portanto não sobrecarrega a memória *)
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

    writeln(FibonacciIterativo(1000));
end.
