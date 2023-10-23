-- Criar um banco de dados chamado "record_company"
CREATE DATABASE record_company;
-- A instrução "GO" separa os lotes de comandos SQL.
GO

-- Criar uma tabela chamada "bands"
CREATE TABLE bands (
    -- Definindo atributos para a tabela "bands"
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    -- A coluna "id" é uma chave primária autoincremental com valores iniciais de 1 e incremento de 1.
    name VARCHAR(255) NOT NULL
    -- A coluna "name" armazena nomes de bandas e não pode ser nula.
);
-- A instrução "GO" separa os lotes de comandos SQL.
GO

-- Criar uma tabela chamada "albums"
CREATE TABLE albums (
    -- Definindo atributos para a tabela "albums"
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    -- A coluna "id" é uma chave primária autoincremental com valores iniciais de 1 e incremento de 1.
    name VARCHAR(255) NOT NULL,
    -- A coluna "name" armazena nomes de álbuns e não pode ser nula.
    release_year INT,
    -- A coluna "release_year" armazena o ano de lançamento dos álbuns (pode ser nula).
    band_id INT NOT NULL FOREIGN KEY REFERENCES bands(id)
    -- A coluna "band_id" é uma chave estrangeira que se relaciona com a tabela "bands" usando a coluna "id".
);
-- A instrução "GO" separa os lotes de comandos SQL.
GO

-- Inserir dados na tabela "bands"
INSERT INTO bands (name)
VALUES ('AC/DC');
-- Inserir a banda AC/DC na tabela "bands".

INSERT INTO bands (name)
VALUES ('Iron Maiden '),('Pink Floyd'),('Metallica');
-- Inserir múltiplas bandas na tabela "bands": Iron Maiden, Pink Floyd e Metallica.

-- Selecionar todos os registros da tabela "bands"
SELECT * FROM bands;
-- Recuperar todos os registros da tabela "bands".

-- Selecionar os primeiros 2 registros da tabela "bands"
SELECT TOP 2 * FROM bands;
-- Recuperar os dois primeiros registros da tabela "bands".

-- Selecionar os nomes das duas primeiras bandas da tabela "bands"
SELECT TOP 2 name FROM bands;
-- Recuperar os nomes das duas primeiras bandas da tabela "bands".

-- Selecionar a coluna "id" renomeada para 'Band ID' e a coluna "name" renomeada para 'Band Name' da tabela "bands"
SELECT id AS 'Band ID', name AS 'Band Name' 
FROM bands;
-- Recuperar os registros da tabela "bands", renomeando as colunas "id" e "name" no resultado da consulta.
GO