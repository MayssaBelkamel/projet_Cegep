USE BD4D5_Pays_Monde
GO

create table Geographie.Drapeau(
	DrapeauId int identity (1,1) not null,
	Identifiant uniqueidentifier not null rowguidcol,
	PaysId int not null,
	constraint PK_Affiche_DrapeauId primary key (DrapeauId)
);
GO


alter table Geographie.Drapeau add constraint UC_Drapeau_Identfiant
UNIQUE (Identifiant);
go

alter table Geographie.Drapeau add constraint DF_Drapeau_Identfiant
Default newid() for Identifiant;
go

alter table Geographie.Drapeau add
Photo varbinary(max) filestream null;
go

alter table Geographie.Drapeau add constraint FK_Drapeau_PaysId
foreign key (PaysId)
references Geographie.Pays(PaysID)
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 2, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Flag_of_Egypt.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 1, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Drapeau-Algerie.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 3, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Drapeau-Maroc.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 4, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\tunisie.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 5, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\nigeria.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 6, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\afrique_du_sud.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 7, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Flag_of_Kenya.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 8, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\ethiopie.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 9, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\ghana.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 10, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\senegal.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 11, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\states.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 12, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\canada.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 13, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\mexique.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 14, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\cuba.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 15, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\costa_rica.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 16, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Drapeau-Bresil.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 17, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\argentine.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 18, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Flag_of_Colombia.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 19, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Drapeau-Perou.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 20, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Drapeau-Chili.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 21, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\venezuela.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 22, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Flag_of_China.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 23, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Flag_of_India.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 24, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\japon.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 25, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\coree_du_sud.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 26, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\thailande.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 27, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\vietnam.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 28, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\indonesie.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 29, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\pakistan.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 30, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\bangladesh.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 31, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\aeu.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 32, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\Flag_of_France.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 33, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\allemagne.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 34, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\royaume_uni.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 35, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\italie.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 36, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\espagne.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 37, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\pologne.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 38, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\suede.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 39, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\norvege.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 40, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\grece.png',
    SINGLE_BLOB
) AS img
go

insert into Geographie.Drapeau (paysId,Photo)
SElect 41, BulkColumn
FROM OPENROWSET(
    BULK 'C:\Users\2483601\Desktop\4D5_tp_Final_Mayssa_Belkamel\4D5_tp2_Mayssa_Belkamel\Images\australie.png',
    SINGLE_BLOB
) AS img
go
