import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tp1_flutter_mayssabelkamel/Services/firebase.dart';
import 'package:tp1_flutter_mayssabelkamel/pages/main.dart';
import '../generated/l10n.dart';
import '../widgets/dialog.dart';
import 'Acceuil.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User? utilisateur = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Connexion(),
    );
  }
}

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _Connexion();
}

class _Connexion extends State<Connexion> {
  final orderContentController = TextEditingController(text: 'Pizza');
  bool _estEnCoursDeChargement = false;
  final dio = Dio();
  String _pseudo = '';
  String _motDePasse = '';


  Future<UserCredential> signInWithGoogle() async {
    // Déclencher le flow d'authentification
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    // Obtenir les détails d'authorisation de la requête
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final GoogleSignInClientAuthorization? authorizationClient =
    await googleUser.authorizationClient.authorizationForScopes(['email']);

    // Créer de nouvelles informations de connexion
    final credential = GoogleAuthProvider.credential(
      accessToken: authorizationClient!.accessToken,
      idToken: googleAuth.idToken,
    );

    // Une fois connecté, retourner UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }





  Future<void> chargeeDonnee()
    async {
      setState(() {
        _estEnCoursDeChargement = true;
      });


      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _pseudo,
            password: _motDePasse
        );



        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Acceuil()),


          );
        }
      } on FirebaseAuthException catch (e) {

        String messageErreur = 'Une erreur est survenue';

        // Capture des erreurs de réseau ou de serveur Firebase
        if (e.code == 'network-request-failed' || e.code == 'unavailable') {
          messageErreur = 'Erreur réseau : Vérifiez votre connexion internet.';
          // Optionnel : Réutiliser votre dialogue d'erreur personnalisé si présent
           afficherDialogueErreur(context, () => chargeeDonnee());
        }
        // Capture des erreurs d'authentification
        else if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
          messageErreur = 'Identifiants ou mot de passe invalides.';
        } else {
          messageErreur = e.message ?? 'Erreur de connexion.';
        }

        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }

        else if(_pseudo.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).nomVide)));
        }

        else if(_motDePasse.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).mdpVide)));
        }
      }
      finally{
        setState(() {
          _estEnCoursDeChargement = false;
        });

      }

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,

        title: Text(S.of(context).Connexion),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(

            mainAxisAlignment: .start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (valeur) {
                    _pseudo = valeur;
                  },
                  decoration: InputDecoration(
                    labelText: S.of(context).Pseudo,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (valeur) {
                    _motDePasse =
                        valeur;
                  },
                  obscureText: true,
                  decoration: InputDecoration(

                    labelText: S.of(context).Mdp,


                    border: const OutlineInputBorder(),
                  ),
                ),
              ),

              MaterialButton(
                color: Colors.lightBlueAccent,
                onPressed: (!_estEnCoursDeChargement)
                    ? ()=>chargeeDonnee()
                    : null,

                disabledColor: Colors.grey,

                child:
                  _estEnCoursDeChargement ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 3,
                    ),
                  ) :  Text(S.of(context).Connexion,
                  style:  TextStyle(color: Colors.black, fontSize: 20), ),


              ),
              MaterialButton(
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const Inscription(
                      ),
                    ),
                  );
                },
                child:  Text(S.of(context).Inscription,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),


              MaterialButton(
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  try {
                    print("Clic détecté : lancement de Google Sign-In...");
                    UserCredential usercreds = await signInWithGoogle();

                    User? user= usercreds.user;
                    addUser(user!);

                    print("Connexion réussie pour : ${usercreds.user?.email}");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Acceuil(),
                      ),
                    );
                  } catch (erreur) {

                    print("L'authentification Google a échoué ! Erreur : $erreur");
                  }
                },
                child:  Text(S.of(context).google,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),


            ],
          ),
        ),
      ),

    );
  }
}
