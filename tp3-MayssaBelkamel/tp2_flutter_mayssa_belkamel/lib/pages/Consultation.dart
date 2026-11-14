import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User, MultipartFile;
import 'package:tp1_flutter_mayssabelkamel/Services/firebase.dart';
import 'package:tp1_flutter_mayssabelkamel/widgets/tiroirNavigation.dart';


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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Consultation(leParametre: "1"),
    );
  }
}

class Consultation extends StatefulWidget {
  final String leParametre;
  const Consultation({Key? key, required this.leParametre}) : super(key: key);

  @override
  State<Consultation> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Consultation> with WidgetsBindingObserver {
  final picker = ImagePicker();

  // on met le fichier dans l'etat pour l'afficher dans la page
  var _imageFile;
  var _publicUrl;
  final User? utilisateur = FirebaseAuth.instance.currentUser;
  List<QueryDocumentSnapshot> taches = [];
  bool _estEnCoursDeChargement = true;
  DocumentSnapshot? tache;

  // ReponseDetailTacheAvecPhoto tache = ReponseDetailTacheAvecPhoto();
  double _currentSliderValue = 0.0;
  bool year2023 = true;

//  String imageNetworkPath = "";
  XFile? pickedImage;
  final stopwatch = Stopwatch();

  /*
  getImage() async {
    ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {});
      sendImage();
    }
  }
*/
  /*
  void sendImage() async {
    if (pickedImage == null) return;

    try {
      FormData formData = FormData.fromMap({
        "taskID": widget.leParametre,
        "file": await MultipartFile.fromFile(
            pickedImage!.path, filename: pickedImage!.name)
      });
      Dio dio = Dio();
      var response = await dio.post(
          "http://10.0.2.2:8080/fichier", data: formData);

      String id = response.data as String;

      setState(() {
        imageNetworkPath = "http://10.0.2.2:8080/fichier/$id";
      });
    } catch (e) {
      print(e);
    }
  }
*/

  sendPicture(XFile xfile) async {

    final User? utilisateurActuel = FirebaseAuth.instance.currentUser;

    if (utilisateurActuel == null) {
      return;
    }

    final supabase = Supabase.instance.client;
    const String bucketid = "taches_images";
    final String uniqueFileName = "${widget.leParametre}_${DateTime.now().millisecondsSinceEpoch}.jpg";

    try {
      await supabase.storage.from(bucketid).upload(
        uniqueFileName,
        File(xfile.path),
      );

      _publicUrl = supabase.storage.from(bucketid).getPublicUrl(uniqueFileName);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(utilisateurActuel.uid)
          .collection('Tasks')
          .doc(widget.leParametre)
          .update({
        'imageUrl': _publicUrl,
      });

      setState(() {});

    } catch (e, stacktrace) {
      print("Détails : $stacktrace");
    }
  }


  Future getImage() async {

    print("ouverture du selecteur d'image");
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print("l'image a ete choisie ${pickedFile.path}");
      _imageFile = File(pickedFile.path);
      setState(() {});

      await sendPicture(pickedFile);
      setState(() { });
    }
  }

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
    try {
      var resultat = await FirebaseFirestore.instance
          .collection('Users')
          .doc(utilisateur?.uid)
          .collection('Tasks')
          .doc(widget.leParametre)
          .get();

      if (mounted) {
        setState(() {
          tache = resultat;
          if (resultat.exists && resultat.data() != null) {
            final data = resultat.data() as Map<String, dynamic>;
            _currentSliderValue =
                (data['pourcentageAvancement'] ?? 0).toDouble();
          }
          _estEnCoursDeChargement = false;

        });
      }
    }on FirebaseException catch (e) {
      String messageErreur = 'Une erreur est survenue';

      // Capture des erreurs de réseau ou de serveur Firebase
      if (e.code == 'network-request-failed' || e.code == 'unavailable') {
        messageErreur = 'Erreur réseau : Vérifiez votre connexion internet.';
        // Optionnel : Réutiliser votre dialogue d'erreur personnalisé si présent
        afficherDialogueErreur(context, () => chargerDonnee());
      }
      // Capture des erreurs d'authentification
      else if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        messageErreur = 'Identifiants ou mot de passe invalides.';
      } else {
        messageErreur = e.message ?? 'Erreur de connexion.';
      }
    }
    /*
    try {
      var resultat = await detailTache(int.parse(widget.leParametre));
      if (mounted) {
        setState(() {
          tache = resultat;
          _currentSliderValue = resultat.pourcentageAvancement.toDouble();
          _estEnCoursDeChargement = false;
          if (tache.photoId != null && tache.photoId.toString().isNotEmpty && tache.photoId.toString() != "0") {
            imageNetworkPath = "http://10.0.2.2:8080/fichier/${tache.photoId}";
          } else {
            imageNetworkPath = "";
          }


        });
      }

    } catch (e) {
      if (mounted) {
        setState(() {
          _estEnCoursDeChargement = false;

        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur réseau ou non connecté')),
        );
      }
    }
    */
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
      setState(() {
        _estEnCoursDeChargement = true;
      });
      chargerDonnee();
      stopwatch.reset();
    } else if (state == AppLifecycleState.paused) {
      stopwatch.start();
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_estEnCoursDeChargement || tache == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(S.of(context).Details),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final mapDonnees = tache!.data() as Map<String, dynamic>;


    final String nom = mapDonnees['nom'] ?? 'Sans nom';
    final String dateLimite = mapDonnees['dateLimte'] ?? '';
    final int avancement = (mapDonnees['pourcentageAvancement'] ?? 0).toInt();
    final double tempsEcoule = (mapDonnees['pourcentageTempsEcoule'] ?? 0.0)
        .toDouble();
    final String urlImage=mapDonnees['imageUrl'] ?? '';

    return Scaffold(
      drawer: const LeTiroir(),
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(S
            .of(context)
            .Details),
      ),
      body: _estEnCoursDeChargement
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                nom,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 30),
              ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.blue),
                title: Text(S
                    .of(context)
                    .Echeance),
                trailing: Text(dateLimite.toString().substring(0, 10)),
              ),
              ListTile(
                leading: const Icon(Icons.trending_up, color: Colors.green),
                title: Text(S
                    .of(context)
                    .Avancement),
                trailing: Text("${_currentSliderValue.toInt()}%"),
              ),
              ListTile(
                leading: const Icon(Icons.access_time, color: Colors.orange),
                title: Text(S
                    .of(context)
                    .TempsDetail),
                trailing: Text("${tempsEcoule}%"),
              ),
              Slider(
                value: _currentSliderValue,
                max: 100,
                divisions: 100,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
              MaterialButton(
                color: Colors.lightBlueAccent,
                onPressed: (!_estEnCoursDeChargement)
                    ? () async {
                  setState(() {
                    _estEnCoursDeChargement = true;
                  });
                  try {
                    updateTask(utilisateur!.uid, widget.leParametre,
                        _currentSliderValue.toInt());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Acceuil(),
                      ),
                    );
                    /*
                    var reponse = await modifierTache(
                        int.parse(widget.leParametre),
                        _currentSliderValue.toInt());
                    print(reponse);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Acceuil(),
                      ),
                    );
                    */

                  } catch (e) {
                    print(e);
                  } finally {
                    setState(() {
                      _estEnCoursDeChargement = false;
                    });
                  }
                }
                    : null,
                disabledColor: Colors.grey,
                child: _estEnCoursDeChargement
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 3,
                  ),
                )
                    : Text(
                  S
                      .of(context)
                      .Enregistrer,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Builder(
                    builder: (context) {

                      if (_imageFile != null) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _imageFile,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        );
                      }


                      if (urlImage != null && urlImage.isNotEmpty) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            urlImage,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,

                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const SizedBox(
                                width: 150,
                                height: 150,
                                child: Center(child: CircularProgressIndicator()),
                              );
                            },

                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.broken_image, size: 50, color: Colors.red),
                              );
                            },
                          ),
                        );
                      }


                      return Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 50, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text(
                              "Aucune image",
                              style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
/*
              imageNetworkPath.isNotEmpty
                  ? SizedBox(
                width: 150,
                height: 150,
                child: CachedNetworkImage(
                  imageUrl: imageNetworkPath,

                  key: ValueKey(imageNetworkPath),
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(

                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),

                  placeholder: (context, url) =>
                  const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.red,
                      ),
                    ),
                  ),

                  errorWidget: (context, url, error) =>
                  const Icon(
                    Icons.broken_image,
                    size: 150,
                    color: Colors.red,
                  ),
                ),
              )
                  : Container(
                color: Colors.grey[300],
                width: 150,
                height: 150,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Cette tâche n'a pas encore d'image",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ),
*/
              const SizedBox(height: 20),

              MaterialButton(
                color: Colors.lightBlueAccent,
                onPressed: () => getImage(),
                child: Text(S
                    .of(context)
                    .changerImage,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
              const SizedBox(height: 20),

              MaterialButton(
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    _estEnCoursDeChargement = true;
                  });
                  try {
                    await deleteTask(utilisateur!.uid, widget.leParametre);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Acceuil(),
                      ),
                    );
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())));
                  }
                  finally {
                    setState(() {
                      _estEnCoursDeChargement = false;
                    });
                  }
                },
                child: Text("Delete",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
