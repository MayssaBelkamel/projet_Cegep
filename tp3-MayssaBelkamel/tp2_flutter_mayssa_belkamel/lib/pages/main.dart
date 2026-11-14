import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:tp1_flutter_mayssabelkamel/pages/Acceuil.dart';

import '../Services/firebase.dart';
import '../services/notifications_service.dart';
import '../firebase_options.dart';
import '../generated/l10n.dart';

import '../widgets/dialog.dart';
import 'Connexion.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await Supabase.initialize(
         url: 'https://creutswzspfpmoexvyqa.supabase.co',
         anonKey: 'sb_publishable_aK3_mIls8f7aGiIfK_MXfw_fnWOdVh5',
        );


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GoogleSignIn.instance.initialize(
      //serverClientId: DefaultFirebaseOptions.currentPlatform.projectId
  );
  runApp(MyApp());
/*
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GoogleSignIn.instance.initialize();

  */
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! ' + user.email!);
      }
    }
    );
    setupFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
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
      home: Connexion(),
        navigatorKey: navigatorKey
    );
  }
}

class Inscription extends StatefulWidget {
  const Inscription({super.key});
  @override
  State<Inscription> createState() => _Inscription();
}

class _Inscription extends State<Inscription> {
  bool _estEnCoursDeChargement = false;
 // final dio = Dio();
  String _pseudo = '';
  String _motDePasse = '';
  String _confirmation = '';
  final User? utilisateur = FirebaseAuth.instance.currentUser;






  Future<void> chargeeDonnee() async {
    if (!mounted) return;
    setState(() {
      _estEnCoursDeChargement = true;
    });


    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _pseudo,
        password: _motDePasse,
      );

      addUser(credential.user!);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Acceuil()),


        );
      }
    } on FirebaseAuthException catch (e) {

      String messageErreur = 'Une erreur est survenue';


      if (e.code == 'network-request-failed' || e.code == 'unavailable') {
        messageErreur = 'Erreur réseau : Vérifiez votre connexion internet.';

        afficherDialogueErreur(context, () => chargeeDonnee());
      }

      else if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        messageErreur = 'Identifiants ou mot de passe invalides.';
      } else {
        messageErreur = e.message ?? 'Erreur de connexion.';
      }

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).mdpCourt)));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).userExiste)));
        print('The account already exists for that email.');
      }

      else if(e.code=='invalid-email'){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).mailFormat)));
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
    catch (e) {
      print(e);
    }
    finally{
      setState(() {
        _estEnCoursDeChargement = false;
      });
    }
/*
    try {
      SignupRequest req = SignupRequest();
      req.nom = _pseudo;
      req.motDePasse = _motDePasse;
      req.confirmationMotDePasse = _confirmation;
      var reponse = await signup(req);

      Session.instance.nomUtilisateur = reponse.nomUtilisateur;
      print(reponse);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Acceuil()),
        );
      }
    } on DioError catch (e) {
      print(e);


      String erreurTexte = e.toString().toLowerCase();
      if (erreurTexte.contains('connection') || erreurTexte.contains('socket')) {
        if (mounted) {
          afficherDialogueErreur(context, () => chargeeDonnee());
        }
        return;
      }


      if (e.response != null && e.response!.data != null) {
        String message = e.response!.data.toString();
        print(message);

        if (!mounted) return;

        if (message == "NomTropCourt") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).nomCourt)));
        } else if (message == "NomTropLong") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).nomLong)));
        } else if (message == "MotDePasseTropCourt") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).mdpCourt)));
        } else if (message == "MotDePasseTropLong") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).mdpLong)));
        } else if (message == "MotsDePasseDifferents") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).mdpCofirm)));
        } else if (message == "NomDejaPris") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).nomExiste)));
        } else if (message == "BadCredentialsException") {
          print('login deja utilise');
        } else {
          print('autre erreurs serveur');
        }
      } else {

        if (mounted) {
          afficherDialogueErreur(context, () => chargeeDonnee());
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _estEnCoursDeChargement = false;
        });
      }
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,

        title: Text(S.of(context).Inscription),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (valeur) { _pseudo = valeur; },
                      decoration: InputDecoration(
                        labelText: S.of(context).Pseudo,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (valeur) { _motDePasse = valeur; },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: S.of(context).Mdp,
                        fillColor: Colors.pinkAccent,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),

                  MaterialButton(
                    color: Colors.lightBlueAccent,
                    disabledColor: Colors.grey,

                    onPressed: (!_estEnCoursDeChargement) ? () => chargeeDonnee() : null,
                    child: _estEnCoursDeChargement
                        ? const SizedBox(
                      height: 20, width: 20,
                      child: CircularProgressIndicator(color: Colors.black, strokeWidth: 3),
                    )
                        : Text(S.of(context).Inscription, style: const TextStyle(color: Colors.black, fontSize: 20)),
                  ),

                  MaterialButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Connexion()));
                    },
                    child: Text(S.of(context).Connexion, style: const TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),




    );
  }
}
