USE BD4D5_Pays_Monde
GO

create table Geographie.PaysFiltreResult(
PaysID int identity (1,1) not null,
NomPays nvarchar(50) not null,
NomContinent nvarchar(50) not null,
Superficie int not null,
Capitale nvarchar(50),
LangueFiltre nvarchar(50)
Constraint PK_PaysFiltreResult_PaysID primary key (PaysID)
);
go