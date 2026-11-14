USE BD4D5_Pays_Monde
GO


create table Geographie.Pays(
PaysID int identity (1,1) not null,
ContinentID int not null,
Nom nvarchar(50) not null,
Superficie int not null,
DateIndependance date,
Constraint PK_Pays_PaysID primary key (PaysID)
);
go
 
create table Geographie.Continent(
ContinentID int identity (1,1) not null,
Nom nvarchar(50) not null,
Superficie int not null,
Constraint PK_Continent_ContinentID primary key (ContinentID)
);
go

create table Geographie.Ville(
VilleID int identity (1,1) not null,
PaysID int not null,
Nom nvarchar(50) not null,
EstCapital bit not null,
Constraint PK_Ville_VilleID primary key (VilleID)
);
go

create table Caracteristique.Climat(
ClimatID int identity (1,1) not null,
Type nvarchar(50) not null,
TempMoyenne int not null,
Constraint PK_Climat_ClimatID primary key (ClimatID)
);
go

create table Caracteristique.Langue(
LangueID int identity (1,1) not null,
Nom nvarchar(50) not null,
Constraint PK_Langue_LangueID primary key (LangueID)
);
go

create table Caracteristique.LanguePays(
LanguePaysID int identity (1,1) not null,
LangueID int not null,
PaysID int not null,
PourcentageLocuteur int not null,
Constraint PK_LanguePays_LanguePaysID primary key (LanguePaysID)
);
go

create table Caracteristique.ClimatPays(
ClimatPaysID int identity (1,1) not null,
ClimatID int not null,
PaysID int not null,
Constraint PK_ClimatPays_ClimatPaysID primary key (ClimatPaysID)
);
go

Alter table [Caracteristique].[ClimatPays] add constraint FK_ClimatPays_ClimatID
foreign key (ClimatID)
references [Caracteristique].[Climat] (ClimatID)
go

Alter table [Caracteristique].[ClimatPays] add constraint FK_ClimatPays_PaysID
foreign key (PaysID)
references [Geographie].[Pays] (PaysID)
go

Alter table [Geographie].[Pays] add constraint FK_Pays_ContinentID
foreign key (ContinentID)
references Geographie.Continent(ContinentID)
go


Alter table [Geographie].[Ville] add constraint FK_Ville_PaysID
foreign key (PaysID)
references [Geographie].[Pays](PaysID)
on delete cascade
go

Alter table [Caracteristique].[LanguePays] add constraint FK_LanguePays_PaysID
foreign key (PaysID)
references [Geographie].[Pays](PaysID)
go

Alter table [Caracteristique].[LanguePays] add constraint FK_LanguePays_LangueID
foreign key (LangueID)
references [Caracteristique].[Langue](LangueID)
go

alter table [Caracteristique].[Climat]
add constraint CK_Climat_Type check (Type in ('Équatorial','Tropical','Aride','Méditerranéen','Océanique','Continental','Polaire','Montagne'))
go

alter table [Geographie].[Pays] add constraint UC_Pays UNIQUE (Nom)
go 

alter table [Geographie].[Ville] add constraint df_Ville_EstCapital DEFAULT 'false' for EstCapital;
go 