class Session {
  static final Session instance = Session._internal();

  Session._internal();

  String nomUtilisateur = '';
  String token = '';
}