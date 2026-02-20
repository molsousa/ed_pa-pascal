program UsoRegistro;

type
Livro = record
    nome : string;
    autor : string;
    editora: string;
    edicao : integer;
end;

var
    l : Livro;
    livroAlocado : ^Livro;

begin
    new(livroAlocado);

    l.nome := 'Projeto de Algoritmos';
    l.autor := 'Nivio Ziviani';
    l.editora := 'Thomson';
    l.edicao := 2;

    writeln('Nome: ', l.nome);
    writeln('Autor: ', l.autor);
    writeln('Editora: ', l.editora);
    writeln('Edição: ', l.edicao);

    writeln;

    livroAlocado^.nome := 'Refugiados';
    livroAlocado^.autor := 'Alan Gratz';
    livroAlocado^.editora := 'Galera';
    livroAlocado^.edicao := 1;

    writeln('Nome: ', livroAlocado^.nome);
    writeln('Autor: ', livroAlocado^.autor);
    writeln('Editora: ', livroAlocado^.editora);
    writeln('Edição: ', livroAlocado^.edicao);

    writeln;

    with livroAlocado^ do
    begin
        writeln('Nome: ', nome);
        writeln('Autor: ', autor);
        writeln('Editora: ', editora);
        writeln('Edição: ', edicao);
    end;
    
    dispose(livroAlocado);
end.