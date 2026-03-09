{
    Ordenação em lista encadeada.
}
program OrdenacaoLista;


{
    Definição de lista encadeada.
}
type
    no = record
             info : integer;
             prox : ^no;
         end;
    Lista = ^no;

var
    l : Lista;

{
    Procedimento para criar lista.
}
procedure criar(var l : Lista);
begin
    l := nil;
end;

{
    Procedimento para inserir na cabeça.
}
procedure inserir(var l : Lista; info : integer);
var aux : Lista;
begin
    new(aux);

    aux^.info := info;
    aux^.prox := l;

    l := aux;
end;

{
    Procedimento para imprimir lista
}
procedure imprimir(l : Lista);
begin
    if l <> nil then
    begin
        write('|', l^.info, '|->');

        imprimir(l^.prox);
    end
    else
        writeln('NULL');
end;

{
    Procedimento para aplicar selection sort.
    Seleciona o menor valor e joga para a posição do mínimo.
    Complexidade:
        No pior caso: O(n²).
        No melhor caso: O(n²)
}
procedure selectionLista(var l : Lista);

var
    i, j, min : Lista;
    troca : integer;

begin
    i := l;

    while i^.prox <> nil do
    begin
        min := i;
        j := i^.prox;

        while j <> nil do
        begin
            if j^.info < min^.info then
                min := j;

            j := j^.prox;
        end;

        troca := min^.info;
        min^.info := i^.info;
        i^.info := troca;

        i := i^.prox;
    end;
end;

begin
    criar(l);

    inserir(l, 21);
    inserir(l, 24);
    inserir(l, 7);
    inserir(l, 12);
    inserir(l, 13);
    inserir(l, 5);
    inserir(l, 3);
    inserir(l, 17);

    selectionLista(l);

    imprimir(l);

end.
