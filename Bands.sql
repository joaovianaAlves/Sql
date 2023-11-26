-- CRIANDO O BANCO DE DADOS
CREATE DATABASE record_company;

-- CRIANDO TABELAS
-- Tabela para armazenar informações sobre bandas musicais
CREATE TABLE bands (
    cd_band INT IDENTITY(1,1) NOT NULL, -- Identificador único da banda
    nm_band VARCHAR(255) NOT NULL,      -- Nome da banda
    qt_members INT                       -- Quantidade de membros na banda
);

-- Tabela para armazenar informações sobre álbuns musicais
CREATE TABLE albums (
    cd_album INT IDENTITY(1,1) NOT NULL,  -- Identificador único do álbum
    nm_album VARCHAR(255) NOT NULL,      -- Nome do álbum
    dt_release DATE,                     -- Data de lançamento do álbum
    cd_band INT NOT NULL,                -- Chave estrangeira referenciando a banda associada ao álbum
);

-- ADICIONANDO CONSTRAINTS DE NOME PARA AS CHAVES PRIMÁRIAS E ESTRANGEIRAS
-- Adicionando chave primária à tabela 'bands'
ALTER TABLE bands
ADD CONSTRAINT PK_BAND 
    PRIMARY KEY(cd_band);

-- Adicionando chave primária à tabela 'albums'
ALTER TABLE albums
ADD CONSTRAINT PK_ALBUM
    PRIMARY KEY(cd_album);

-- Adicionando chave estrangeira à tabela 'albums' referenciando 'cd_band' da tabela 'bands'
ALTER TABLE albums
ADD CONSTRAINT FK_ALBUM
    FOREIGN KEY(cd_band) REFERENCES bands(cd_band);

-- INSERINDO DADOS NA TABELA 'bands'
-- Inserindo informações sobre algumas bandas na tabela 'bands'
INSERT INTO bands(nm_band, qt_members)
VALUES ('Metallica', 4),('Iron Maiden', 5),('Ankor',2),('Queen',6);

-- INSERINDO DADOS NA TABELA 'albums'
-- Inserindo informações sobre alguns álbuns na tabela 'albums'
INSERT INTO albums(nm_album, dt_release, cd_band)
VALUES 
    ('Master of Puppets', '1986-01-01', 1),   -- Exemplo de álbum com data de lançamento em 1986
    ('The Number of the Beast', '1982-01-01', 2), -- Exemplo de álbum com data de lançamento em 1982
    ('White Dragon', '2019-01-01', 3),          -- Exemplo de álbum com data de lançamento em 2019
    ('Run to the hills', '1982-01-01', 1);

-- ATUALIZANDO DADOS NA TABELA 'albums'
-- Atualizando a banda associada ao álbum 'Run to the hills' para Iron Maiden (cd_band = 2)
UPDATE albums 
SET cd_band = 2
WHERE nm_album = 'Run to the hills';

-- SELECIONANDO TODOS OS REGISTROS DA TABELA 'albums'
SELECT * FROM albums;

-- SELECIONANDO REGISTROS DISTINTOS DA TABELA 'albums'
SELECT DISTINCT nm_album, dt_release, cd_band FROM albums;

-- SELECIONANDO TODOS OS REGISTROS DA TABELA 'bands'
SELECT * FROM bands;

-- SELECIONANDO AS DUAS PRIMEIRAS BANDAS DA TABELA 'bands'
SELECT TOP(2) nm_band FROM bands;

-- SELECIONANDO DADOS RENOMEANDO AS COLUNAS NA TABELA 'bands'
SELECT cd_band AS 'ID', nm_band AS 'Band Name' 
FROM bands;

-- SELECIONANDO TODOS OS REGISTROS DA TABELA 'bands' ORDENADOS POR NOME DA BANDA
SELECT * FROM bands ORDER BY nm_band;

-- SELECIONANDO ÁLBUNS COM DATAS DE LANÇAMENTO ENTRE 1982 E 2023
SELECT * FROM albums WHERE dt_release BETWEEN '1982' AND '2023';

-- EXCLUINDO REGISTROS DA TABELA 'albums'
DELETE FROM albums WHERE nm_album = 'TEST';

-- SELECIONANDO TODOS OS REGISTROS DAS TABELAS 'bands' E 'albums' COM JUNÇÃO
SELECT * FROM bands
JOIN albums ON bands.cd_band = albums.cd_band;

-- SELECIONANDO TODOS OS REGISTROS DAS TABELAS 'bands' E 'albums' COM JUNÇÃO INTERNA
SELECT * FROM bands
INNER JOIN albums ON bands.cd_band = albums.cd_band;

-- SELECIONANDO TODOS OS REGISTROS DAS TABELAS 'bands' E 'albums' COM JUNÇÃO À ESQUERDA
SELECT * FROM bands
LEFT JOIN albums ON bands.cd_band = albums.cd_band;

-- SELECIONANDO A MÉDIA DE MEMBROS NA BANDA
SELECT AVG(qt_members) AS 'Members AVG' FROM bands;

-- SELECIONANDO A SOMA TOTAL DE MEMBROS NA BANDA
SELECT SUM(qt_members) AS 'Total Members' FROM bands;

-- Contando o número de álbuns para cada banda (usando cd_band)
SELECT cd_band, COUNT(cd_band) FROM albums 
GROUP BY cd_band;

-- Contando o número de álbuns para cada banda (usando nm_band)
SELECT b.nm_band AS band_name, COUNT(a.cd_album) as num_albums
FROM bands AS b
LEFT JOIN albums AS a ON b.cd_band = a.cd_band
GROUP BY b.nm_band;