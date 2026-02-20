program UsoString;

var
    cidade : string;
    nome : packed array [1..32] of char;
    pais : string[16];
    estado : pchar;

begin
    cidade := 'Foz do Iguaçu';
    estado := 'Paraná';

    write('Escreva seu nome: ');
    readln(nome);

    write('Escreva o nome do seu pais: ');
    readln(pais);

    writeln('Nome: ', nome);
    writeln('Cidade: ', cidade);
    writeln('Estado: ', estado);
    writeln('Pais: ', pais);
end.