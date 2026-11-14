USE BD4D5_Pays_Monde
GO

-- Créer la table Client dans le schéma Clients tel qu'indiqué dans l'énoncé 
CREATE TABLE Clients.Client(
	ClientId int identity (1,1) not null,
	Nom nvarchar (50) not null,
	Prenom nvarchar (50) not null,
	Courriel nvarchar (256) not null,
	MotDePasseHache varbinary (32) not null,
	MdpSel varbinary(16) not null,
	constraint PK_Client_ClientId primary key (ClientId)
);
GO



-- Unicité du courriel dans la table
Alter table Clients.Client add constraint UC_Client_Courriel UNIQUE (Courriel);
go

-- Créer la procédure permettant à un client de s'enregistrer sur la plateforme
CREATE PROCEDURE Clients.USP_CreerClient
	@Nom nvarchar(50),
	@Prenom nvarchar(50),
	@Courriel nvarchar(256),
	@MotDePasse nvarchar(100)
AS
BEGIN
	-- Sel Aléatoire
	Declare @MdpSel varbinary(16)=CRYPT_GEN_RANDOM(16);

	-- Concaténation mdp et sel
	Declare @MdpEtSel nvarchar(116)=CONCAT(@MotDePasse, @MdpSel);

	-- Hachage du mot de passe
	Declare @MdpHachage varbinary(32)=Hashbytes('SHA2_256', @MdpEtSel);

	-- Insertion dans la table Client
	insert into Clients.Client (Nom, Prenom, Courriel, MotDePasseHache, MdpSel)
	values
	(@Nom, @Prenom, @Courriel, @MdpHachage, @MdpSel)

END
GO

-- Procédure d'authentification
CREATE PROCEDURE Clients.USP_AuthClient
	@Courriel nvarchar(50),
	@MotDePasse nvarchar(50)
AS
BEGIN
	declare @Sel varbinary(16);
	declare @MdpHache varbinary(32);
	select @Sel=MdpSel, @MdpHache=MotDePasseHache
	from Clients.Client
	Where Courriel=@Courriel

	if hashbytes('SHA2_256', concat(@MotDePasse, @Sel))=@MdpHache
	begin 
		Select * from CLients.Client where Courriel=@Courriel;
	end 
	else 
	begin 
		select top 0 * from CLients.Client;
	end
END
GO

-- Insertion de qques Clients
EXEC Clients.USP_CreerClient
@Nom = 'Vallières', @Prenom = 'Chantal', @Courriel = 'chantal.valliere@montpetit.ca', @MotDePasse = '123456'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Adam-Larocque', @Prenom = 'Olivier', @Courriel = 'olivier.adam-larocque@montpetit.ca', @MotDePasse = '456789'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Bournival', @Prenom = 'Laurence', @Courriel = 'laurence.bournival@montpetit.ca', @MotDePasse = 'qwerty'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Brucher-Fafard', @Prenom = 'Guillaume', @Courriel = 'guillaume.brucher-fafard@montpetit.ca', @MotDePasse = 'asdfgh'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Chalifour', @Prenom = 'David', @Courriel = 'david.chalifour@montpetit.ca', @MotDePasse = 'zxcvbn'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Desrochers', @Prenom = 'Félix', @Courriel = 'felix.desrochers@montpetit.ca', @MotDePasse = 'poiuytre'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Gagné', @Prenom = 'Ameni', @Courriel = 'ameni.gagne@montpetit.ca', @MotDePasse = 'lkjhgfds'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Gammoudi', @Prenom = 'Guillaume', @Courriel = 'guillaume.gammoudi@montpetit.ca', @MotDePasse = 'mnbvcxz'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Gobeil-Bouchard', @Prenom = 'François', @Courriel = 'francois.gobeil-bouchard@montpetit.ca', @MotDePasse = '147258'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Milon', @Prenom = 'Graham', @Courriel = 'graham.milon@montpetit.ca', @MotDePasse = '369258'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Morin', @Prenom = 'Mégane', @Courriel = 'megane.morin@montpetit.ca', @MotDePasse = '258741'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Normand', @Prenom = 'Guillaume', @Courriel = 'guillaume.normand@montpetit.ca', @MotDePasse = '987654'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Proulx', @Prenom = 'Bruno', @Courriel = 'bruno.proulx@montpetit.ca', @MotDePasse = '789456'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Rukundo', @Prenom = 'Zachary', @Courriel = 'zachary.rukundo@montpetit.ca', @MotDePasse = '321654'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Tanguay', @Prenom = 'Mario', @Courriel = 'mario.tanguay@montpetit.ca', @MotDePasse = 'plmoknijb'
GO
EXEC Clients.USP_CreerClient
@Nom = 'Gammoudi', @Prenom = 'Jamil', @Courriel = 'jamil.gammoudi@montpetit.ca', @MotDePasse = 'qazwsxedc'
GO

