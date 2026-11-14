// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest()
      ..nom = json['nom'] as String
      ..motDePasse = json['motDePasse'] as String
      ..confirmationMotDePasse = json['confirmationMotDePasse'] as String;

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'motDePasse': instance.motDePasse,
      'confirmationMotDePasse': instance.confirmationMotDePasse,
    };

ConnexionRequest _$ConnexionRequestFromJson(Map<String, dynamic> json) =>
    ConnexionRequest()
      ..nom = json['nom'] as String
      ..motDePasse = json['motDePasse'] as String;

Map<String, dynamic> _$ConnexionRequestToJson(ConnexionRequest instance) =>
    <String, dynamic>{'nom': instance.nom, 'motDePasse': instance.motDePasse};

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse()..nomUtilisateur = json['nomUtilisateur'] as String;

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{'nomUtilisateur': instance.nomUtilisateur};

ReponseAccueilItemAvecPhoto _$ReponseAccueilItemAvecPhotoFromJson(
  Map<String, dynamic> json,
) => ReponseAccueilItemAvecPhoto()
  ..id = (json['id'] as num).toInt()
  ..nom = json['nom'] as String
  ..pourcentageAvancement = (json['pourcentageAvancement'] as num).toInt()
  ..pourcentageTemps = (json['pourcentageTemps'] as num).toInt()
  ..dateLimite = DateTime.parse(json['dateLimite'] as String)
  ..idPhoto = (json['idPhoto'] as num).toInt();

Map<String, dynamic> _$ReponseAccueilItemAvecPhotoToJson(
  ReponseAccueilItemAvecPhoto instance,
) => <String, dynamic>{
  'id': instance.id,
  'nom': instance.nom,
  'pourcentageAvancement': instance.pourcentageAvancement,
  'pourcentageTemps': instance.pourcentageTemps,
  'dateLimite': instance.dateLimite.toIso8601String(),
  'idPhoto': instance.idPhoto,
};

RequeteAjoutTache _$RequeteAjoutTacheFromJson(Map<String, dynamic> json) =>
    RequeteAjoutTache()
      ..nom = json['nom'] as String
      ..dateLimite = DateTime.parse(json['dateLimite'] as String);

Map<String, dynamic> _$RequeteAjoutTacheToJson(RequeteAjoutTache instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'dateLimite': instance.dateLimite.toIso8601String(),
    };

ReponseDetailTacheAvecPhoto _$ReponseDetailTacheAvecPhotoFromJson(
  Map<String, dynamic> json,
) => ReponseDetailTacheAvecPhoto()
  ..nom = json['nom'] as String
  ..dateLimite = DateTime.parse(json['dateLimite'] as String)
  ..pourcentageAvancement = (json['pourcentageAvancement'] as num).toInt()
  ..pourcentageTemps = (json['pourcentageTemps'] as num).toInt()
  ..photoId = (json['photoId'] as num).toInt();

Map<String, dynamic> _$ReponseDetailTacheAvecPhotoToJson(
  ReponseDetailTacheAvecPhoto instance,
) => <String, dynamic>{
  'nom': instance.nom,
  'dateLimite': instance.dateLimite.toIso8601String(),
  'pourcentageAvancement': instance.pourcentageAvancement,
  'pourcentageTemps': instance.pourcentageTemps,
  'photoId': instance.photoId,
};
