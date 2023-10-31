CREATE DATABASE Livraria
GO

--CREATING THE TABLES
CREATE TABLE Assunto(
	sg_Assunto CHAR(3) NOT NULL,
	ds_Assunto VARCHAR(255)
);

CREATE TABLE Editora(
	cd_Editora INT IDENTITY(1,1) NOT NULL, 
	nm_Editora VARCHAR(255)
);

CREATE TABLE Autor(
	cd_Autor INT IDENTITY(1,1) NOT NULL,
	nm_Autor VARCHAR(40), 
	ds_EnderecoAutor VARCHAR(255)
);

CREATE TABLE Livro (
	cd_Livro INT IDENTITY(1,1) NOT NULL, 
	nm_Titulo VARCHAR(40), 
	vl_Livro FLOAT, 
	dt_Lancamento DATE, 
	sg_Assunto CHAR(3), 
	cd_Editora INT
);

CREATE TABLE Autor_Livro(
	cd_Livro INT NOT NULL,
	cd_Autor INT NOT NULL
);
GO

--CREATING THE PRIMARY KEYS
ALTER TABLE Assunto
	ADD CONSTRAINT pk_Assunto PRIMARY KEY (sg_Assunto)
GO

ALTER TABLE Editora
	ADD CONSTRAINT pk_Editora PRIMARY KEY (cd_Editora)
GO

ALTER TABLE Livro
	ADD CONSTRAINT pk_Livro PRIMARY KEY (cd_Livro)
GO

ALTER TABLE Autor
	ADD CONSTRAINT pk_Autor PRIMARY KEY (cd_Autor)
GO

ALTER TABLE Autor_Livro
	ADD CONSTRAINT pk_Autor_Livro PRIMARY KEY (cd_Livro,cd_Autor)
GO

--CREATING THE FOREING KEYS
ALTER TABLE Livro
	ADD CONSTRAINT fk_Editora FOREIGN KEY (cd_Editora) REFERENCES Editora
GO

ALTER TABLE Livro
	ADD CONSTRAINT fk_Assunto FOREIGN KEY (sg_Assunto) REFERENCES Assunto
GO

ALTER TABLE Autor_Livro
	ADD CONSTRAINT fk_Livro FOREIGN KEY (cd_Livro) REFERENCES Livro
GO

ALTER TABLE Autor_Livro
	ADD CONSTRAINT fk_Autor FOREIGN KEY (cd_Autor) REFERENCES Autor
GO

--Insert Autors

Insert Into Assunto
	Values 	('D','Drama'),
		('A','Aventura'),
		('C','Com�dia')
go

Insert Into Editora
	Values 	('Erica'),
		('Campus')
go

Insert Into Autor
	Values 	('MARIA DA SILVA','RUA DO GRITO, 45'),
		('ANDR� CARDOSO','AV. DA SAUDADE,325'),
		('TATIANA SOUZA','AV. BRASIL, 4011'),		
		('MARCO ANDRADE','RUA DO IMPERADOR, 778')
go

Insert Into Livro
	( nm_Titulo, cd_Editora, sg_Assunto, vl_Livro)
	Values 	('Mar em F�ria',1,'D',65.00),
		('O Aeroporto',2,'A',30.00),
		('Einstein',2,'D',4.50),
		('Mar sem fim',1,'A',58.00)
go

INSERT INTO Autor_Livro (cd_Livro, cd_Autor)
VALUES (1, 3),
       (1, 2),
       (2, 1),
       (3, 4),
       (4, 2),
       (4, 3)

--Solve Exercises

ALTER TABLE Livro
	ADD CONSTRAINT chk_dt_Lancamento CHECK (dt_Lancamento > GETDATE())

SELECT Autor_Livro.cd_Livro, COUNT(*)
FROM Autor_Livro
GROUP BY Autor_Livro.cd_Livro
HAVING COUNT(*) >= 2

SELECT cd_Editora, 
AVG(vl_Livro) 
FROM Livro
WHERE vl_Livro > 45
GROUP BY cd_Editora

SELECT MAX(cd_Livro), MAX(nm_Titulo), sg_Assunto, MAX(vl_Livro) 
FROM Livro
WHERE vl_Livro <> 0 AND (sg_Assunto = 'D' OR sg_Assunto = 'A')
GROUP BY Livro.sg_Assunto
