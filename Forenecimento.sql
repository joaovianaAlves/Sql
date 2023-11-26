Create database Equipa
go
use Equipa
go
-- Tabelas
Create Table Equipamento(
	cd_Equipamento int not null,
	ds_Equipamento varchar(40))
go
Create Table Fornecedor(
	cd_Forn int not null,
	nm_Forn varchar(40),
	nm_Matriz varchar(30))
go
Create Table Custo(
	cd_Forn int not null,
	cd_Equipamento int not null,
	vl_Custo money)
go

-- Chaves Primarias
Alter Table Equipamento
	Add Constraint PK_Equip 
	Primary Key (cd_Equipamento)
go
Alter Table Fornecedor
	Add Constraint PK_Forn 
	Primary Key (cd_Forn)
go
Alter Table Custo
	Add Constraint PK_Custo
	Primary Key (cd_Forn,cd_Equipamento)
go

-- Chaves Estrangeiras
go
Alter Table Custo
	Add Constraint FK_Equipamento
	Foreign Key (cd_Equipamento)
	References Equipamento
	On Delete Cascade
go
Alter Table Custo
	Add Constraint FK_Forn
	Foreign Key (cd_Forn)
	References Fornecedor
	On Delete Cascade
go

-- Registros
Insert Into Equipamento
	values 	(2000,'Servidores Alpha'),
		(3000,'Servidores Intel'),
		(4020,'Placa de vídeo de 2 Gb'),
		(4040,'Placa de vídeo de 4 Gb'),
		(4100,'Placa bluetooth notebook'),
		(4200,'Placa bluetooth PC'),
		(4300,'Placa mãe Asus'),
		(4400,'Placa mãe gamer'),
		(4501,'Placa de rede NE 2000'),
		(4502,'Placa de rede DEC 305'),
		(4503,'Placa de rede 3com'),
		(4504,'Placa de rede SMC'),
		(5010,'Hard Disk 1 Tb'),
		(5020,'Hard Disk 2 Tb'),
		(5021,'Hard Disk 2 Tb SCSI'),
		(5040,'Hard Disk 4 Tb'),
		(6020,'Pente de memória 8 Gb') 
go
Insert Into Fornecedor
	Values 	(001,'ISM','São Paulo'),
		(002,'M.A Informática','Rio de Janeiro'),
		(003,'Decatron','Rio de Janeiro'),
		(004,'S&S Systems','Santos'),
		(005,'Enterdata','Santos'),
		(006,'Sisgraph','São Paulo'),
		(007,'Digital','Rio de Janeiro'),
		(008,'NetDb','Santos'),
		(009,'CenterSoft','Santos'),
		(010,'TrTec','Campinas')
go
Insert Into Custo
	Values 	(001,5010,130.00),
		(001,4040,100.00),
		(010,4501,60.00),
		(009,4400,200.00),
		(008,4200,230.00),
		(007,2000,80000.00),
		(006,3000,42000.00),
		(005,4502,150.00),
		(004,4020,90.00),
		(002,4020,85.00),
		(003,2000,65000.00),
		(001,6020,250.00),
		(004,4100,198.00),
		(005,4100,190.00),
		(008,4504,180.00)

-- Atualização de descrição de equipamento
UPDATE Equipamento
SET ds_Equipamento = 'Placa de vídeo de 16 Gb'
WHERE cd_Equipamento = 4040;

-- Adição e remoção de coluna na tabela Equipamento
ALTER TABLE Equipamento
ADD qt_Equipamento INT;

ALTER TABLE Equipamento
DROP COLUMN qt_Equipamento;

-- Alteração de nome da coluna na tabela Custo
EXEC sp_rename 'Custo.vl_Custo', 'vl_Equipamento', 'COLUMN';

-- Exclusão de registros na tabela Custo
DELETE FROM Custo
WHERE cd_Forn >= 9 AND vl_Equipamento > 150;

-- Atualização de valores na tabela Custo
UPDATE Custo
SET vl_Equipamento = vl_Equipamento * 1.138
WHERE cd_Forn IN (001, 005, 008) AND vl_Equipamento >= 120;

-- Consulta de equipamentos com pelo menos dois fornecedores
SELECT
    cd_Equipamento,
    COUNT(cd_Forn) AS QuantidadeFornecedores
FROM
    Custo
GROUP BY
    cd_Equipamento
HAVING
    COUNT(cd_Forn) >= 2;

-- Consulta de média de valores por fornecedor
SELECT cd_Forn, AVG(vl_Equipamento) AS MediaEquipamento
FROM Custo
GROUP BY cd_Forn;

-- Consulta de equipamentos que possuem "Hard Disk" no nome
SELECT cd_Equipamento, ds_Equipamento
FROM Equipamento
WHERE ds_Equipamento LIKE '%Hard Disk%';

SELECT C.cd_Equipamento,
	   E.ds_Equipamento,
       C.vl_Equipamento,
       F.nm_Forn AS NomeFornecedor
FROM Custo AS C
JOIN Equipamento as E ON C.cd_Equipamento = E.cd_Equipamento
JOIN Fornecedor AS F ON C.cd_Forn = F.cd_Forn
WHERE vl_Equipamento > 100 AND vl_Equipamento < 200

SELECT 
    E.ds_Equipamento,
    COUNT(C.cd_Forn) AS QuantidadeFornecedores
FROM 
    Equipamento AS E
JOIN 
    Custo AS C ON E.cd_Equipamento = C.cd_Equipamento
GROUP BY 
    E.ds_Equipamento
HAVING 
    COUNT(C.cd_Forn) >= 2;

SELECT C.cd_Equipamento,
	   F.nm_Matriz,
	   F.nm_Forn,
	   F.cd_Forn
FROM Custo AS C
JOIN Fornecedor AS F ON C.cd_Forn = F.cd_Forn
WHERE F.nm_Matriz IN ('Santos', 'São Paulo');