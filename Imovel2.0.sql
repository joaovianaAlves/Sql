--Banco de Dados
Create Database Teste
go

Use Teste
go

--Tabela Vendedor--

Create Table Vendedor(
	cd_Vendedor int not null, --Pois e uma PK
	nm_Vendedor varchar(40),
	ds_Endereco varchar(40),
	cd_CPF varchar(11),
	nm_Cidade varchar(40),
	nm_Bairro varchar(40),
	sg_Estado char(02),
	cd_Telefone varchar(20),
	ds_Email varchar(70)
)
go

--Tabela Comprador--

Create Table Comprador(
	cd_Comprador int not null, --Pois e uma PK
	nm_Comprador varchar(40),
	ds_Endereco varchar(40),
	cd_CPF varchar(11),
	nm_Cidade varchar(40),
	nm_Bairro varchar(40),
	sg_Estado char(02),
	cd_Telefone varchar(20),
	ds_Email varchar(70)
)
go

--Tabela Oferta--

Create Table Oferta(
	cd_Comprador int not null, --Pois e uma PK
	cd_Imovel int not null, --Pois e uma PK
	vl_Oferta money,
	dt_Oferta datetime
)


--Tabela Estado--

Create Table Estado(
	sg_Estado char(02) not null, --Pois e uma PK
	nm_Estado varchar(40)
)
go

--Tabela Cidade--

Create Table Cidade(
	cd_Cidade int not null, --Pois e uma PK
	sg_Estado char(02) not null, --Pois e uma PK
	nm_Cidade varchar(40)
)
go

--Tabela Bairro--

Create Table Bairro(
	cd_Bairro int not null, --Pois e uma PK
	cd_Cidade int not null, --Pois e uma PK
	sg_Estado char(02) not null, --Pois e uma PK
	nm_Bairro varchar(40)
)
go

--Tabela Imovel--

Create Table Imovel(
	cd_Imovel int not null, --Pk
	cd_Vendedor int, --Fk
	cd_Bairro int, --Fk
	cd_Cidade int, --Fk
	sg_Estado char(2), --Fk
	ds_Endereco varchar(40),
	qt_AreaUtil decimal(10,2),
	qt_AreaTotal decimal(10,2),
	ds_Imovel varchar(400),
	vl_Imovel money,
	qt_Ofertas int,
	ic_Vendido char(1),
	dt_Lance datetime,
	qt_ImovelIndicado int
)	
go

--Tabela Faixa Imovel--

Create Table FaixaImovel(
	cd_Faixa int not null, --Pois e uma PK
	nm_Faixa varchar(20),
	vl_Maximo money,
	vl_Minimo money
)
go

--Primary Keys--

Alter Table Vendedor
	Add Primary Key(cd_Vendedor)
go

Alter Table Comprador
	Add Primary Key(cd_Comprador)
go

Alter Table Oferta
	Add Primary Key(cd_Comprador,cd_Imovel)
go

Alter Table Imovel
	Add Primary Key(cd_Imovel)
go

Alter Table Estado
	Add Primary Key(sg_Estado)
go

Alter Table Cidade
	Add Primary Key(cd_Cidade,sg_Estado)
go

Alter Table Bairro
	Add Primary Key(cd_Bairro,cd_Cidade,sg_Estado)
go

Alter Table FaixaImovel
	Add Primary Key(cd_Faixa)

--Foreign Keys--

Alter Table Imovel
	Add Foreign Key (cd_Vendedor)
	References Vendedor

Alter Table Imovel
	Add Foreign Key (cd_Bairro, cd_Cidade, sg_Estado)
	References Bairro

Alter Table Oferta
	Add Foreign Key (cd_Comprador)
	References Comprador

Alter Table Oferta
	Add Foreign Key (cd_Imovel)
	References Imovel

Alter Table Bairro
	Add Foreign Key (cd_Cidade,sg_Estado)
	References Cidade

Alter Table Cidade
	Add Foreign Key (sg_Estado)
	References Estado

--Indexes--

Create nonClustered index indImovelOferta
	on Oferta(cd_Imovel)
Create nonClustered index indValorOferta
	on Oferta(vl_Oferta Desc)
