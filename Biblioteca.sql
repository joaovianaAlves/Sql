create database Biblioteca
go
use Biblioteca
go

--Tabela
Create Table Assunto(
	sg_Assunto char(01) not null,
	ds_Assunto varchar(40))
go
Create Table Editora(
	cd_Editora int not null,
	nm_Editora varchar(40))
go
Create Table Autor(
	cd_Autor int not null,
	nm_Autor varchar(40),
	ds_EnderecoAutor varchar(50))
go
Create Table Livro(
	cd_Livro int not null,
	nm_Titulo varchar(30),
	vl_Livro money,
	dt_Lancamento datetime,
	sg_Assunto char(01),
	cd_Editora int)
go
Create Table Autor_Livro(
	cd_Autor int not null,
	cd_Livro int not null,)
go

--PKS
Alter Table Assunto 
		add primary key (sg_Assunto)
go

Alter Table Editora	
	add primary key (cd_Editora)
go

Alter Table Autor
		add primary key (cd_Autor)
go

Alter Table Livro
		add primary key (cd_Livro)
go

Alter Table Autor_Livro
		add primary key (cd_Autor, cd_Livro)
go

--Fks
Alter table Livro 
		add foreign key (sg_Assunto)
		References Assunto
go

Alter table Livro
		add foreign key (cd_Editora)
		References Editora
go

Alter Table Autor_Livro
		add foreign key (cd_Autor)
		References Autor
go

Alter Table Autor_Livro
		add foreign key (cd_Livro)
		References Livro
go

--Deletando a tabela assunto
alter table Livro
		drop Constraint [FK__Livro__sg_Assunt__2C3393D0]
go

alter table Assunto
		drop Constraint [PK__Assunto__7FC186B604089D68]
go

--Adicionando coluna

Alter Table Livro
		add qt_Edicao int
		Constraint CK_Edicao check (qt_Edicao < 20)
go

Alter Table Livro
		Drop Constraint CK_Edicao
go

Alter Table Livro
		Drop Column qt_Edicao
go

exec sp_Rename 'Livro.vl_Livro','vl_VolumeLivro'
exec sp_Rename 'Autor_Livro','Livro_Autor'

Alter Table Autor
		add dt_Nascimento datetime
		Constraint CK_autor_datanasc check (year(dt_Nascimento) < year(2007))
go

Alter Table Autor
		drop Constraint CK_autor_datanasc
go

Alter Table Livro_Autor
	drop Constraint [FK__Autor_Liv__cd_Au__2E1BDC42]
go

Alter Table Autor
	drop Constraint [PK__Autor__B7DF2D381933C187]
go

exec sp_Rename 'Autor.cd_Autores','cd_Autor'

Alter Table Autor
	add Constraint PK_cdAutores primary key(cd_Autor)
go

Alter Table Livro_Autor
	add Constraint FK_cdAutores foreign key(cd_Autor)
	References Autor
go




