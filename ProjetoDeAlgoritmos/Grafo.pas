{
    Grafo de adjacência é a representação de um grafo por matriz.
    Caso duas arestas tenham conexões diferentes, é feita uma ligação de um vértice a outro.
    Caso duas arestas tenham a mesma conexão, é feita uma ligação de um vértice a ele mesmo.
    Para esse grafo foi considerado que o mesmo tenha peso entre cada ligação.
}
program GrafoMatrizAdjacencia;

const
    MaxNumVertices = 100;
    MaxNumArestas = 4500;

// Definição de tipos e estrutura do grafo
type
    TipoValorVertice = 0..MaxNumVertices;
    TipoPeso = integer;
    TipoGrafo = record
                    Mat : array[TipoValorVertice, TipoValorVertice] of TipoPeso;
                    NumVertices : 0..MaxNumVertices;
                    NumArestas : 0..MaxNumArestas;
                end;
    Apontador = TipoValorVertice;

// criação de variaveis para testar o grafo
var
    aux : apontador;
    i : integer;
    v1, v2, adj : TipoValorVertice;
    peso : TipoPeso;
    grafo : tipografo;
    nVertices : TipoValorVertice;
    nArestas : 0..MaxNumArestas;
    fimListaAdj : boolean;

// Procedimento para criação de um grafo
procedure FGVazio(var Grafo : TipoGrafo);
var i, j : integer;
begin
    for i := 0 to Grafo.NumVertices do
        for j := 0 to Grafo.NumVertices do
            Grafo.Mat[i, j] := 0;
end;

// Procedimento para inserir uma aresta no grafo
procedure InsereAresta(var V1, V2 : TipoValorVertice; var Peso : TipoPeso; var Grafo : TipoGrafo);
begin
    Grafo.Mat[V1, V2] := Peso;
end;

// Função que atribui verdadeiro caso já exista uma aresta
function ExisteAresta(Vertice1, Vertice2 : TipoValorVertice; var Grafo : TipoGrafo) : boolean;
begin
    ExisteAresta := Grafo.mat[Vertice1, Vertice2] > 0;
end;

// Função que atribui verdadeiro caso a lista de adjacentes esteja vazia
function ListaAdjVazia(var Vertice : TipoValorVertice; var Grafo : TipoGrafo) : boolean;
var
    aux : Apontador;
    ListaVazia : boolean;

begin
    ListaVazia := true;
    aux := 0;

    while (aux < Grafo.NumVertices) and ListaVazia do
        if Grafo.Mat[Vertice, aux] > 0 then
            ListaVazia := false
        else
            aux := aux + 1;

    ListaAdjVazia := ListaVazia = true;
end;

// Função para atribuir o valor do primeiro vértice da lista de adjacencia
function PrimeiroListaAdj(var Vertice : TipoValorVertice; var Grafo : TipoGrafo) : Apontador;
var
    aux : apontador;
    ListaVazia : boolean;

begin
    ListaVazia := true;
    aux := 0;

    while (aux < grafo.NumVertices) and ListaVazia do
        if grafo.mat[vertice, aux] > 0 then
        begin
            PrimeiroListaAdj := aux;
            ListaVazia := false;
        end
        else
            aux := aux + 1;

    if aux = grafo.NumVertices then
        writeln('Erro: Lista vazia');
end;

// Procedimento para retornar 'Adj' da lista de adjacencia de 'Vertice'
// Tambem retorna o peso relacionado a (vertice, adj)
procedure proxAdj(var Vertice : TipoValorVertice;
                  var Grafo : TipoGrafo;
                  var Adj : TipoValorVertice;
                  var Peso: TipoPeso;
                  var prox : apontador;
                  var fimListaAdj : boolean);
begin
    adj := prox;
    peso := grafo.mat[vertice, prox];
    prox := prox+1;

    while (prox < grafo.NumVertices) and (grafo.mat[vertice, prox] = 0) do
        prox := prox + 1;

    if prox = grafo.NumVertices then
        fimListaAdj := true;
end;

// Procedimento para retirar uma aresta do grafo
procedure retiraAresta(var v1, v2 : TipoValorVertice; var peso : TipoPeso; var grafo : TipoGrafo);
begin
    if grafo.mat[v1, v2] = 0 then
        writeln('Aresta não existe')

    else
    begin
        peso := grafo.mat[v1, v2];
        grafo.mat[v1, v2] := 0;
    end;
end;

// Procedimento para imprimir matriz representando o grafo
procedure imprimeGrafo(var grafo : tipografo);

var
    i, j : integer;

begin
    write('   ');

    for i := 0 to grafo.NumVertices-1 do
        write(i:3);

    writeln;

    for i := 0 to grafo.NumVertices-1 do
    begin
        write(i:3);
        for j := 0 to grafo.NumVertices-1 do
            write(grafo.mat[i,j]:3);

        writeln;
    end;
end;

begin
    write('Número vértices: ');
    readln(nVertices);
    write('Número arestas: ');
    readln(nArestas);

    grafo.NumVertices := nVertices;
    grafo.NumArestas := 0;

    FGVazio(grafo);

    for i := 0 to nArestas-1 do
    begin
        write('Insere v1, v2, peso: ');
        readln(v1, v2, peso);

        InsereAresta(v1, v2, peso, grafo);
        InsereAresta(v2, v1, peso, grafo);
    end;

    imprimeGrafo(grafo);
    readln;

    write('insere v1, v2, peso:' );
    readln(v1, v2, peso);

    if ExisteAresta(v1, v2, grafo) then
        writeln('Aresta já existe')

    else
    begin
        grafo.NumArestas := grafo.NumArestas + 1;
        InsereAresta(v1, v2, peso, grafo);
        InsereAresta(v2, v1, peso, grafo);
    end;

    imprimeGrafo(grafo);
    readln;

    write('Lista adjacentes de: ');
    read(v1);

    if not ListaAdjVazia(v1, grafo) then
    begin
        aux := PrimeiroListaAdj(v1, grafo);
        fimListaAdj := false;

        while not fimListaAdj do
        begin
            proxAdj(v1, grafo, adj, peso, aux, fimListaAdj);
            write(adj:2, ' (', peso, ')');
        end;
        writeln;
        readln;
    end;

    write('Retira aresta v1, v2: ');
    readln(v1, v2);

    if ExisteAresta(v1, v2, grafo) then
    begin
        grafo.NumArestas := grafo.NumArestas-1;
        retiraAresta(v1, v2, peso, grafo);
        retiraAresta(v2, v1, peso, grafo);
    end
    else
        writeln('Aresta não existe');

    imprimeGrafo(grafo);
    readln;

    write('Existe aresta v1, v2: ');
    readln(v1, v2);

    if ExisteAresta(v1, v2, grafo) then
        writeln('sim')

    else
        writeln('não');
end.
