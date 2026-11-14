import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tp1_flutter_mayssabelkamel/pages/Acceuil.dart';
import 'package:tp1_flutter_mayssabelkamel/pages/creationTache.dart';
import 'package:tp1_flutter_mayssabelkamel/http/lib_http.dart';
import 'package:tp1_flutter_mayssabelkamel/models/session.dart';

import '../generated/l10n.dart';
import '../pages/Connexion.dart';

import '../services/notifications_service.dart';


class LeTiroir extends StatefulWidget {
  const LeTiroir({super.key});

  @override
  State<LeTiroir> createState() => LeTiroirState();
}

class LeTiroirState extends State<LeTiroir> {
  final orderContentController = TextEditingController(text: 'Pizza');
  bool _estEnCoursDeChargement = false;
  final User? utilisateur = FirebaseAuth.instance.currentUser;
  late final String courrielAfficher = utilisateur?.email ?? "Aucun courriel associé";

  @override
  Widget build(BuildContext context) {

    var listView = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
   courrielAfficher,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          dense: true,
          title:  Text(S.of(context).Accueil),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Acceuil(),
              ),
            );
          },
        ),


        ListTile(
          dense: true,
          title:  Text(S.of(context).Ajouter),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Creationtache(),
              ),
            );
          },
        ),


        /*
        ListTile(
          dense: true,
          title:  _estEnCoursDeChargement
              ? const Row(
            children: [
              SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
              ),
              SizedBox(width: 10),
             // Text("Déconnexion...", style: TextStyle(color: Colors.red)),
            ],
          )
              :  Text(S.of(context).Deconnexion),
          onTap:  (!_estEnCoursDeChargement)
              ? () async {
            setState(() {
              _estEnCoursDeChargement = true;
            });
            try {
              var reponse = await deconnexion();
              print(reponse);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Connexion(),
                ),
              );
            } on DioError catch (e) {
              print(e);
              String message = e.response!.data;
              print(message);
              if (message == "BadCredentialsException") {
                print('login deja utilise');
              } else {
                print('autre erreurs');
              }
            }
            finally {

              setState(() {
                _estEnCoursDeChargement = false;
              });
            }
          }: null,


        ),
*/
        ListTile(
          dense: true,
          leading: const Icon(Icons.notifications_active),
          title:  Text(S.of(context).btnJetton),
          onTap: () async {
            Navigator.of(context).pop(); // Ferme le tiroir


            String? token = await FirebaseMessaging.instance.getToken();


            if (token != null) {
              try {

                await enregistrerJetonNotification(token);

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Abonnement aux notifications réussi !")),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Échec de l'abonnement au serveur.")),
                );
              }
            } else {
              print("Impossible de récupérer le token FCM.");
            }
          },
        ),


        ListTile(
          dense: true,
          leading: const Icon(Icons.notification_important),
          title:  Text(S.of(context).btnNotification),
          onTap: () async {
            Navigator.of(context).pop();
            try {
              await testerNotification();
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Test de notification déclenché !")),
              );
            } catch (e) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Erreur lors du déclenchement du test.")),
              );
            }
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.notification_important),
          title:  Text(S.of(context).Deconnexion),
          onTap: () async {
            await GoogleSignIn.instance.signOut();
            await FirebaseAuth.instance.signOut();
            setState(() {});
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Connexion(),
              ),
            );
          },

        ),




      ],
    );

    return Drawer(
      child: Container(
        color: const Color(0xFFFFFFFF),
        child: listView,
      ),
    );
  }
}
