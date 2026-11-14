
use master 
go

-- CREATION de la BD R22_Billeterie
CREATE DATABASE BD4D5_Pays_Monde
go

USE BD4D5_Pays_Monde
GO

-- Configuration de FILESTREAM
-- nous avons vu ça lors de la rencontre 19
exec sp_configure filestream_access_level, 2 reconfigure 

alter database BD4D5_Pays_Monde
add filegroup FG_Images contains filestream;
go

alter database BD4D5_Pays_Monde
add file (
	name=FG_Imsges,
	filename='C:\EspaceLabo\FG_Images_2483601'
)
to filegroup FG_Images
go