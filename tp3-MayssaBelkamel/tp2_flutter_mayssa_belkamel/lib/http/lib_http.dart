import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:tp1_flutter_mayssabelkamel/http/transfert.dart';

const String urlBase = 'http://10.0.2.2:8080/';

final CookieJar _cookieJar = CookieJar();

final Dio _dio = Dio(BaseOptions(
  baseUrl: urlBase,
))..interceptors.add(CookieManager(_cookieJar));

Future<SignupResponse> signup(SignupRequest req) async {
  try {
    var response = await _dio.post(
      'id/inscription',
      data: req.toJson(),
      options: Options(headers: {'content-type': 'application/json'}),
    );
    print(response);
    return SignupResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<SignupResponse> connexion(ConnexionRequest req) async {
  try {
    var response = await _dio.post(
      'id/connexion',
      data: req.toJson(),
      options: Options(headers: {'content-type': 'application/json'}),
    );
    print(response);
    return SignupResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<String> deconnexion() async {
  try {
    var response = await _dio.post(
      'id/deconnexion',
      options: Options(headers: {'content-type': 'application/json'}),
    );
    return " ";
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<List<ReponseAccueilItemAvecPhoto>> acceuil() async {
  try {
    var response = await _dio.get(
      'api/accueil/photo',
      options: Options(headers: {'content-type': 'application/json'}),
    );
    var listeJSON = response.data as List;
    var listeTache = listeJSON.map((elementJSON) {
      return ReponseAccueilItemAvecPhoto.fromJson(elementJSON);
    }).toList();
    return listeTache;
  } catch (e) {
    print(e);
    rethrow;
  }
}



Future<String> creerTache(RequeteAjoutTache req) async {
  try {
    var response = await _dio.post(
      'tache/ajout',
      data: req.toJson(),
      options: Options(headers: {'content-type': 'application/json'}),
    );
    print(response);
    return response.data.toString();
  } catch (e) {
    print(e);
    rethrow;
  }
}


Future<ReponseDetailTacheAvecPhoto> detailTache(int id) async {
  try {
    var response = await _dio.get(
      'api/detail/photo/$id',
      options: Options(headers: {'content-type': 'application/json'}),
    );
    print(response);
    return ReponseDetailTacheAvecPhoto.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}


Future<String> modifierTache(int id, int progression) async {
  try {
    var response = await _dio.get(
      'tache/progres/$id/$progression',
      options: Options(headers: {'content-type': 'application/json'}),
    );
    print(response);
    return response.data.toString();
  } catch (e) {
    print(e);
    rethrow;
  }
}



Future<void> enregistrerJetonNotification(String token) async {
  try {

    await _dio.post('enregistrer-jeton-notification', data: token);
    print("Jeton enregistré avec succès sur le serveur");
  } catch (e) {
    print("Erreur lors de l'enregistrement du jeton: $e");
    rethrow;
  }
}


Future<void> testerNotification() async {
  try {
    await _dio.post('test/notifications');
    print("Requête de test envoyée au serveur");
  } catch (e) {
    print("Erreur lors du test de notification: $e");
    rethrow;
  }
}



