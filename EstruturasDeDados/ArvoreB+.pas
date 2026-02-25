(*
    Essa implementação de árvore B+ possui um número de chaves 
    igual ao tamanho da ORDEM, o objetivo é facilitar o split
    fazendo com que o número de chaves e filhos cheguem ao estágio
    de overflow de forma literal não sendo necessário verificações
    a mais. Essa implementação desconsidera o ponteiro para a página
    pai por não incluir remoção. Além disso, em sua estrutura é possível
    verificar se um nó é folha ou não para verificação de intervalos. 
*)
program ArvoreBMais;

(* Constante para determinar a ORDEM da árvore *)
const 
    ORDEM = 5;

(* Definição de tipos de intervalo para impressão *)
type
    TipoIntervalo = (aberto, fechado);

(* Definição de estrutura para B+ *)
(* Para essa implementação, cada nó tem sua verificação de folha *)
type
    ponteiro = record
        chave : array[0..ORDEM-1] of integer;
        filhos : array[0..ORDEM] of ^ponteiro;
        num_chaves : integer;
        folha : boolean;
    end;

(* Definição de estrutura de nó para B+ *)
type
    BMais = ^ponteiro;

var
    r : BMais;

(* Função para criar árvore B+ *)
(* Atribui o valor nil para árvore B+ *)
function criar() : BMais;
begin
    criar := nil;
end;

(* Função para verificar se um nó é vazio *)
(* Atribui o valor true se for vazia *)
function vazia(r : BMais) : boolean;
begin
    vazia := (r = nil);
end;

(* Função para verificar se um nó teve overflow *)
(* Atribui o valor true se overflow *)
function overflow(r : BMais) : boolean;
begin
    overflow := (r^.num_chaves = ORDEM);
end;

(* Procedimento cauda para contar nós *)
(* Atribui o número de total de nós à variável total *)
procedure conta_nos_aux(r : BMais; var total : integer);

var
    i : integer;

begin
    if vazia(r) then

    else
    begin
        total := total + 1;

        for i := 0 to r^.num_chaves do
        begin
            conta_nos_aux(r^.filhos[i], total);
        end;
    end;
end;

(* Função chamadora para contar nós *)
(* Atribui o número total de nós *)
function conta_nos(r : BMais) : integer;

begin
    if vazia(r) then
    begin
        conta_nos := 0;
        exit;
    end;

    conta_nos_aux(r, conta_nos);
end;

(* Procedimento para corrigir intervalo de B+ *)
(* Percorre em níveis os nós e engaveta para corrigir o intervalo de ida *)
procedure corrigir_intervalo(r : BMais);

var
    aux, nos_intervalo : array of BMais;
    i, j, k, fim, inicio : integer;
    atual, prox : BMais;

begin
    k := 0;
    fim := 0;
    inicio := 0;

    setlength(aux, conta_nos(r));
    setlength(nos_intervalo, conta_nos(r));

    aux[fim] := r;
    fim := fim + 1;

    while fim > inicio do
    begin
        atual := aux[inicio];
        inicio := inicio +1;

        if atual^.folha then
        begin
            nos_intervalo[k] := atual;
            k := k + 1;
        end;

        for j := 0 to atual^.num_chaves do
        begin
            if (atual^.filhos[j] <> nil) then
            begin
                aux[fim] := atual^.filhos[j];
                fim := fim + 1;
            end;
        end;
    end;

    for i := 0 to k-2 do
    begin
        atual := nos_intervalo[i];
        prox := nos_intervalo[i+1];
        atual^.filhos[ORDEM] := prox;
    end;
end;

(* Função para aplicar split a um nó *)
(* Atribui um novo nó a direita do nó passado como parâmetro *)
(* Atribui o valor da chave sucessora para a variável M *)
function split(r : BMais; var m : integer) : BMais;

var
    q, i : integer;

begin
    new(split);

    for i := 0 to ORDEM do
        split^.filhos[i] := nil;

    q := Trunc(r^.num_chaves / 2);
    m := r^.chave[q];

    if r^.folha then
    begin
       split^.num_chaves := (r^.num_chaves - q);

       split^.folha := true;
       r^.num_chaves := q;

       for i := 0 to split^.num_chaves-1 do
        begin
            split^.chave[i] := r^.chave[q+i];
        end;
    end
    else
    begin
        split^.filhos[0] := r^.filhos[q+1];

        split^.num_chaves := (r^.num_chaves - q - 1);

        split^.folha := false;
        r^.num_chaves := q;

        for i := 0 to split^.num_chaves-1 do
        begin
            split^.chave[i] := r^.chave[q+i+1];
            split^.filhos[i+1] := r^.filhos[q+i+2];
        end;
    end;
end;

(* Procedimento para adicionar chaves a direita *)
(* Empurra novas chaves à direita, não faz verificação de overflow *)
(* Adiciona novo filho se necessário *)
procedure adicionar_direita(r : BMais; pos : integer; k : integer; p : BMais);

var
    i : integer;

begin
    for i := (r^.num_chaves) downto pos do
    begin
        r^.chave[i] := r^.chave[i-1];
        r^.filhos[i+1] := r^.filhos[i];
    end;

    r^.chave[pos] := k;
    r^.filhos[pos+1] := p;
    r^.num_chaves := r^.num_chaves + 1; 
end;

(* Função para buscar posição para inserir nova chave *)
(* Atribui o valor true se a chave já estiver na árvore (não permitindo valores repetidos) *)
function busca_pos(r : BMais; chave : integer; var pos : integer) : boolean;

var
    i : integer;

begin
    for i := 0 to (r^.num_chaves) do
    begin
        pos := i;
        if r^.chave[i] = chave then
        begin
            busca_pos := true;
            exit;
        end
        
        else if chave < r^.chave[i] then
        begin
            break;
        end;
    end;

    busca_pos := false;
end;

(* Procedimento em cauda para inserir chave *)
(* Insere chave em árvore B+, aplica split se necessário *)
procedure inserir_aux(r : BMais; chave : integer);

var
    pos, m : integer;
    p : BMais;

begin
    if not(busca_pos(r, chave, pos)) then
    begin
        if r^.folha then
            adicionar_direita(r, pos, chave, nil)

        else
        begin
            inserir_aux(r^.filhos[pos], chave);

            if (overflow(r^.filhos[pos])) then
            begin
                p := split(r^.filhos[pos], m);
                adicionar_direita(r, pos, m, p);
            end;
        end;
    end;
end;

(* Função auxiliar para criar página B+ *)
(* Atribui o valor de um novo nó B+ *)
function criaPagina(chave : integer; folha : boolean; num_chaves : integer) : BMais;

var
    i : integer;

begin
    new(criaPagina);

    criaPagina^.chave[0] := chave;
    criaPagina^.num_chaves := num_chaves;
    criaPagina^.folha := folha;
    
    for i := 0 to ORDEM do
    begin
        criaPagina^.filhos[i] := nil; 
    end;
end;

(* Função para inserir chave em B+ *)
(* Atribui o valor de novo nó B+, muda a raiz se necessário *)
function inserir(r : BMais; chave : integer) : BMais;

var
    x, nova_raiz : BMais;
    i, m : integer;

begin
    if vazia(r) then
    begin
       inserir := criaPagina(chave, true, 1);
    end
    else
    begin
        inserir_aux(r, chave);

        if overflow(r) then
        begin
            x := split(r, m);
            nova_raiz := criaPagina(m, false, 1);

            nova_raiz^.filhos[0] := r;
            nova_raiz^.filhos[1] := x;

            for i := Trunc((ORDEM/2)+1) to ORDEM-1 do
                r^.filhos[i] := nil;

            inserir := nova_raiz;
            exit;
        end;
        corrigir_intervalo(r);

        inserir := r;
    end;
end;

(* Procedimento para imprimir intervalo completo de B+ *)
procedure ler_intervalo(r : BMais);

var
    i : integer;

begin
    while (r^.filhos[0] <> nil) do
        r := r^.filhos[0];

    while (not vazia(r)) do
    begin
        write('[');

        for i := 0 to r^.num_chaves-1 do
        begin
            write(r^.chave[i]);

            if i < r^.num_chaves-1 then
                write(',');
        end;

        write(']');

        r := r^.filhos[ORDEM];
    end;

    writeln;
end;

(* Procedimento para imprimir em níveis *)
procedure imprimirNiveis(r : BMais);

var
    i, j, nivel, inicio, fim : integer;
    aux : array of BMais;
    atual : BMais;

begin
    if vazia(r) then
        writeln('nil')

    else
    begin
        fim := 0;
        inicio := 0;
        setlength(aux, conta_nos(r));

        aux[fim] := r;
        fim := fim + 1;

        while fim > inicio do
        begin
            nivel := fim - inicio;

            for i := 0 to nivel-1 do
            begin
                atual := aux[inicio];
                inicio := inicio + 1;

                write('[');

                for j := 0 to atual^.num_chaves-1 do
                begin
                    write(atual^.chave[j]);

                    if j < atual^.num_chaves-1 then
                        write(',');
                end;

                write(']');

                if (atual^.folha) then
                    write('->')
                else
                    write(' ');

                for j := 0 to atual^.num_chaves do
                begin
                    if (atual^.filhos[j] <> nil) then
                    begin
                        aux[fim] := atual^.filhos[j];
                        fim := fim + 1;
                    end;
                end;
            end;
            if (fim = inicio) and (not r^.folha) then
                writeln('NULL');

            writeln;
        end;
    end;
end;

(* Procedimento para imprimir intervalo aberto *)
procedure imprimir_aberto(r : BMais; a, b : integer);

var i : integer;

begin
    if vazia(r) then
        exit;

    for i := 0 to r^.num_chaves-1 do
        if (r^.chave[i] > a) and (r^.chave[i] < b) then
            write(r^.chave[i], ' ');

    imprimir_aberto(r^.filhos[ORDEM], a, b);
end;

(* Procedimento para imprimir intervalo fechado *)
procedure imprimir_fechado(r : BMais; a, b : integer);

var i : integer;

begin
    if vazia(r) then
        exit;

    for i := 0 to r^.num_chaves-1 do
        if (r^.chave[i] >= a) and (r^.chave[i] <= b) then
            write(r^.chave[i], ' ');

    imprimir_fechado(r^.filhos[ORDEM], a, b);
end;

(* Procedimento de chamada para impressão em intervalo *)
(* Recebe uma enumeração como parâmetro para indicar se a impressão é em intervalo aberto ou fechado *)
procedure imprimir_intervalo(r : BMais; a, b : integer; af : TipoIntervalo);
begin
    if vazia(r) then
        exit;

    while not vazia(r^.filhos[0]) do
        r := r^.filhos[0];

    if af = aberto then
        imprimir_aberto(r, a, b)
    else
        imprimir_fechado(r, a, b);

    writeln;
end;

begin
    r := criar();

    r := inserir(r, 9);
    r := inserir(r, 17);
    r := inserir(r, 11);
    r := inserir(r, 28);
    r := inserir(r, 12);
    r := inserir(r, 4);
    r := inserir(r, 8);
    r := inserir(r, 2);
    r := inserir(r, 7);
    r := inserir(r, 32);
    r := inserir(r, 19);
    r := inserir(r, 5);
    r := inserir(r, 24);
    r := inserir(r, 35);
    r := inserir(r, 1);
    r := inserir(r, 20);
    r := inserir(r, 27);
    r := inserir(r, 25);
    r := inserir(r, 45);
    r := inserir(r, 39);
    r := inserir(r, 23);
    r := inserir(r, 21);
    r := inserir(r, 22);

    imprimirNiveis(r);

    ler_intervalo(r);

    imprimir_intervalo(r, 13, 32, fechado);
end.