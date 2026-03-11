program GrafoListaArranjo;

const
    MaxNumVertices = 100;
    MaxNumArestas = 4500;
    MaxTam = MaxNumVertices + 2*MaxNumArestas;

type
    TipoValorVertice = 0..MaxNumVertices;
    TipoPeso = integer;
    TipoTam = 0..MaxTam;
    TipoGrafo = record
                    Cab : array[TipoTam] of TipoTam;
                    Prox : array[TipoTam] of TipoTam;
                    Peso : array[TipoTam] of TipoTam;
                    ProxDisponivel : TipoTam;
                    NumVertices : 0..MaxNumVertices;
                    NumArestas : 0..MaxNumArestas;
                end;
    Apontador = TipoTam;

var
    aux : apontador;
    i : integer;
    v1, v2, adj : TipoValorVertice;
    peso : TipoPeso;
    grafo : tipografo;
    nVertices : TipoValorVertice;
    nArestas : 0..MaxNumArestas;
    fimListaAdj : boolean;

procedure FGVazio(var Grafo : TipoGrafo);
var i : integer;
begin
    for i := 0 to grafo.NumVertices do
    begin
        grafo.prox[i] := 0;
        grafo.cab[i] := i;
        grafo.ProxDisponivel := grafo.NumVertices;
    end;
end;

procedure InsereAresta(var v1, v2 : TipoValorVertice;
                       var peso : TipoPeso;
                       var Grafo : TipoGrafo);
var Pos : integer;
begin
    pos := grafo.ProxDisponivel;

    if grafo.ProxDisponivel = MaxTam then
        writeln('Não há espaço disponível para a aresta')
    else
    begin
        grafo.ProxDisponivel := grafo.ProxDisponivel + 1;
        grafo.Prox[grafo.cab[v1]] := pos;
        grafo.cab[pos] := v2;
        grafo.cab[v1] := pos;
        grafo.prox[pos] := 0;
        grafo.peso[pos] := peso;
    end;
end;

function ExisteAresta(vertice1, vertice2 : TipoValorVertice; var Grafo : TipoGrafo) : boolean;
var
    aux : Apontador;
    encontrouAresta : boolean;
begin
    aux := grafo.prox[vertice1];
    encontrouAresta := false;

    while (aux <> 0) and (encontrouAresta = false) do
    begin
        if vertice2 = grafo.cab[aux] then
            encontrouAresta := true;

        aux := grafo.prox[aux];
    end;
    ExisteAresta := encontrouAresta;
end;

function ListaAdjVazia(var Vertice : TipoValorVertice;
                       var Grafo : TipoGrafo) : boolean;
begin
    ListaAdjVazia := Grafo.prox[vertice] = 0;
end;

function PrimeiroListaAdj(var Vertice : TipoValorVertice;
                          var Grafo : TipoGrafo) : Apontador;
begin
    PrimeiroListaAdj := grafo.prox[vertice];
end;

procedure proxAdj(var Vertice : TipoValorVertice; var Grafo : TipoGrafo;
                  var Adj : TipoValorVertice; var Peso : TipoPeso;
                  var prox : apontador; var FimListaAdj : boolean);
begin
    adj := grafo.cab[prox];
    peso := grafo.peso[prox];
    prox := grafo.prox[prox];

    if prox = 0 then
        FimListaAdj := true;
end;

procedure retiraAresta(var v1, v2 : TipoValorVertice;
                       var peso : TipoPeso; var grafo : TipoGrafo);
var
    aux, auxAnterior : Apontador;
    encontrouAresta : boolean;

begin
    auxAnterior := v1;
    aux := grafo.prox[v1];
    encontrouAresta := false;

    while (aux <> 0) and (encontrouAresta = false) do
    begin
        if v2 = grafo.cab[aux] then
            encontrouAresta := true

        else
        begin
            auxAnterior := aux;
            aux := grafo.Prox[aux];
        end;
    end;

    if encontrouAresta then
        grafo.cab[aux] := MaxNumVertices + 2*MaxNumArestas
    else
        writeln('Aresta não existe');
end;

procedure imprimeGrafo(var grafo : TipoGrafo);
var i : integer;
begin
    writeln('    Cab Prox Peso');

    for i := 0 to Grafo.NumVertices + 2*Grafo.NumArestas-1 do
        writeln(i:2, grafo.cab[i]:4, grafo.prox[i]:4, grafo.peso[i]:4);
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
        grafo.NumArestas := grafo.NumArestas+1;

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
