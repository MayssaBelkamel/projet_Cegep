
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tp1_flutter_mayssabelkamel/Services/firebase.dart';
import 'package:tp1_flutter_mayssabelkamel/pages/Consultation.dart';
import 'package:tp1_flutter_mayssabelkamel/pages/creationTache.dart';
import 'package:tp1_flutter_mayssabelkamel/widgets/tiroirNavigation.dart';
import '../firebase_options.dart';
import '../generated/l10n.dart';
import 'package:connectivity_plus/connectivity_plus.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Acceuil(),
    );
  }
}

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Acceuil> with WidgetsBindingObserver {
  List<QueryDocumentSnapshot> taches = [];
//  final dio = Dio();


  bool _estEnCoursDeChargement = true;
  bool _dialogueEstAffiche = false;


  final stopwatch = Stopwatch();

  Future<void> chargerDonnee() async {
    final List<ConnectivityResult>  resultatsConnexion = await Connectivity().checkConnectivity();

    if (resultatsConnexion.contains(ConnectivityResult.none)) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Mode hors ligne : aucune connexion réseau détectée."),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 4),
          ),
        );
      }

    }
    /*
    if (resultatsConnexion.contains(ConnectivityResult.none)) {
      if (mounted) {
        setState(() {
          _pasDeReseau = true;
          _estEnCoursDeChargement = false;
        });
      }
      return; // On arrête la fonction ici
    }

     */
    final User? utilisateur = FirebaseAuth.instance.currentUser;

    if (utilisateur == null) {
      if (mounted) {
        setState(() {

          _estEnCoursDeChargement = false;
          taches = [];
        });
      }
      print("Aucun utilisateur connecté.");
      return;
    }

    if (!mounted) return;
    setState(() {
      _estEnCoursDeChargement = true;

    });

    try {
      taches = await getTasks(utilisateur);
      if (mounted) {
        setState(() async {

          _estEnCoursDeChargement = false;
        });
      }
    } catch (e) {

      print('Erreur lors de la récupération Firestore : $e');

      if (mounted) {
        setState(() {
          _estEnCoursDeChargement = false;
        });
      }
    }


  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    chargerDonnee();
  }

  @override
  void dispose() {
    // TODO 2 On doit retirer l'observer à la destruction du widget
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO 3 Les changements d'état de l'application sont gérés ici
    if (state == AppLifecycleState.resumed) {
      stopwatch.stop();


      if (!_dialogueEstAffiche) {
        chargerDonnee();
      }

      stopwatch.reset();
    } else if (state == AppLifecycleState.paused) {
      stopwatch.start();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeTiroir(),
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(S
            .of(context)
            .Accueil),
      ),
      body: _estEnCoursDeChargement
          ? const Center(child: CircularProgressIndicator())
          : taches.isEmpty
          ? Center(child: Text(S
          .of(context)
          .pasDeTache))
          : ListView.builder(
        itemCount: taches.length,
        itemBuilder: (context, index) {

          final doc = taches[index];
          final tache = doc.data() as Map<String, dynamic>;
          final String idTache = doc.id;

          final String url= tache['imageUrl'] ?? '';
          final String nom = tache['nom'] ?? 'Sans nom';
          final String dateLimite = tache['dateLimte'] ?? '';
          final int avancement = tache['pourcentageAvancement'].toInt() ?? 0;
          final double tempsEcoule = (tache['pourcentageTempsEcoule'] ?? 0.0)
              .toDouble();

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: url.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  url,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,

                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) return child;
                    return frame != null
                        ? child
                        : const SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  },

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                ),
              )
                  : const Icon(Icons.image, size: 50),
              title: Text(
                nom.trim(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${S
                    .of(context)
                    .Echeance}: ${dateLimite.length >= 10 ? dateLimite
                    .substring(0, 10) : dateLimite}\n"
                    "${S
                    .of(context)
                    .Avancement}: $avancement% |  ${S.of(context).TempsDetail} : ${tempsEcoule
                    .toStringAsFixed(1)}%",
              ),
              trailing: const Icon(
                  Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Consultation(
                          leParametre: idTache,
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),





      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Creationtache(),
            ),
          );
          chargerDonnee();
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),


    );
  }
}
