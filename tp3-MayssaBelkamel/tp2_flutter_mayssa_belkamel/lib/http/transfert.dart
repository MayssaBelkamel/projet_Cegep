import 'package:json_annotation/json_annotation.dart';
part 'transfert.g.dart';


@JsonSerializable()
class SignupRequest {
  SignupRequest();

  String nom = '';
  String motDePasse = '';
  String confirmationMotDePasse = '';

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}

@JsonSerializable()
class ConnexionRequest {
  ConnexionRequest();

  String nom = '';
  String motDePasse = '';


  factory ConnexionRequest.fromJson(Map<String, dynamic> json) =>
      _$ConnexionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConnexionRequestToJson(this);
}

@JsonSerializable()
class SignupResponse {
  SignupResponse();

  String nomUtilisateur = '';

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}

@JsonSerializable()
class ReponseAccueilItemAvecPhoto {
  ReponseAccueilItemAvecPhoto();

  int id = 0;
  String nom = '';
  int pourcentageAvancement = 0;
  int pourcentageTemps = 0;
  DateTime dateLimite = DateTime.now() ;
  int idPhoto=0;


  factory ReponseAccueilItemAvecPhoto.fromJson(Map<String, dynamic> json) =>
      _$ReponseAccueilItemAvecPhotoFromJson(json);

  Map<String, dynamic> toJson() => _$ReponseAccueilItemAvecPhotoToJson(this);
}

@JsonSerializable()
class RequeteAjoutTache {
  RequeteAjoutTache ();

  String nom = '';
  DateTime dateLimite = DateTime.now();


  factory RequeteAjoutTache.fromJson(Map<String, dynamic> json) =>
      _$RequeteAjoutTacheFromJson(json);

  Map<String, dynamic> toJson() => _$RequeteAjoutTacheToJson(this);
}

@JsonSerializable()
class ReponseDetailTacheAvecPhoto {
  ReponseDetailTacheAvecPhoto();

  String nom = '';
  DateTime dateLimite = DateTime.now();
  int pourcentageAvancement = 0;
  int pourcentageTemps = 0;
  int photoId=0;


  factory ReponseDetailTacheAvecPhoto.fromJson(Map<String, dynamic> json) =>
      _$ReponseDetailTacheAvecPhotoFromJson(json);

  Map<String, dynamic> toJson() => _$ReponseDetailTacheAvecPhotoToJson(this);
}

/*
@JsonSerializable()
class ReponseDetailTacheAvecPhoto {
  ReponseDetailTacheAvecPhoto();

  String nom = '';
  DateTime dateLimite = DateTime.now();
  int pourcentageAvancement = 0;
  int pourcentageTemps = 0;
  int photoId=0;


  factory ReponseDetailTacheAvecPhoto.fromJson(Map<String, dynamic> json) =>
      _$ReponseDetailTacheAvecPhotoFromJson(json);

  Map<String, dynamic> toJson() => _$ReponseDetailTacheAvecPhotoToJson(this);
}
*/

