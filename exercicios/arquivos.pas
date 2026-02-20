program UsoArquivos;

type
    Estudante = record
        nome : string;
        idade : integer;
        ra : int64;
        curso : string;
    end;

type
    fEstudante = file of Estudante;

var
    e : Estudante;
    f : file of Estudante;

procedure escrita(var f : fEstudante);
begin
    Assign(f, 'estudante.dat');
    rewrite(f);

    with e do
    begin
        nome := 'Marcos Sousa';
        idade := 21;
        ra := 221123;
        curso := 'Ciência da Computação';
    end;

    write(f, e);
    close(f);
end;

procedure leitura(var f : fEstudante; e : Estudante);
begin
    Assign(f, 'estudante.dat');
    reset(f);

    while not eof(f) do

    begin
        read(f, e);

        with e do
        begin
            writeln('Nome: ', nome);
            writeln('Idade: ', idade);
            writeln('RA: ', ra);
            writeln('Curso: ', curso);
        end;
    end; 

    close(f);
end;

begin
    escrita(f);
    leitura(f, e);
end.