USE BD4D5_Pays_Monde
GO

create procedure Geographie.USP_PaysFiltreSimple
@ContinentID int =null,
@LangueNom nvarchar(50)=null,
@DoitAvoirCapitale bit=null

as 
begin


	declare @LangueID int=null;

	if @LangueNom is not null
	begin
		select @LangueID=LangueID
		from caracteristique.Langue
		where Nom=@LangueNom;
	end

	select 
	    P.PaysID,
        P.Nom AS NomPays,
        C.Nom AS NomContinent,
        P.Superficie,
        (SELECT TOP 1 V.Nom 
         FROM Geographie.Ville V 
         WHERE V.PaysID = P.PaysID AND V.EstCapital = 1) AS Capitale,
        @LangueNom AS LangueFiltre
    FROM Geographie.Pays P
    JOIN Geographie.Continent C ON C.ContinentID = P.ContinentID
    WHERE 
        (@ContinentID IS NULL OR P.ContinentID = @ContinentID)
        AND (
            @LangueID IS NULL
            OR EXISTS (
                SELECT 1 
                FROM Caracteristique.LanguePays LP
                WHERE LP.PaysID = P.PaysID AND LP.LangueID = @LangueID
            )
        )
        AND (
            @DoitAvoirCapitale IS NULL
            OR EXISTS (
                SELECT 1 
                FROM Geographie.Ville V
                WHERE V.PaysID = P.PaysID AND V.EstCapital = @DoitAvoirCapitale
            )
        )
    ORDER BY P.Nom;
end
go