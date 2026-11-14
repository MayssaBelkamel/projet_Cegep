import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp1_flutter_mayssabelkamel/Services/firebase.dart';
import 'package:tp1_flutter_mayssabelkamel/http/lib_http.dart';
import 'package:tp1_flutter_mayssabelkamel/widgets/tiroirNavigation.dart';
import 'package:tp1_flutter_mayssabelkamel/http/transfert.dart';

import '../generated/l10n.dart';
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

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  Creationtache(),
    );
  }
}

class Creationtache extends StatefulWidget {
  const Creationtache({super.key});

  @override
  State<Creationtache> createState() => _Creationtache();
}

class _Creationtache extends State<Creationtache> {

  bool _estEnCoursDeChargement = false;
  final dio = Dio();
  String _nomTache = '';
  DateTime? selectedDate;
  final TextEditingController _dateController = TextEditingController();
  final User? utilisateur = FirebaseAuth.instance.currentUser;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        _dateController.text = pickedDate.toString().substring(0, 10);
      });
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
            .Ajouter),
      ),
      body: Center(


        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (valeur) {
                    _nomTache = valeur;
                  },
                  decoration: InputDecoration(
                    labelText: S
                        .of(context)
                        .nomTache,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _dateController,
                  onTap: () {
                    _selectDate();
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: S
                        .of(context)
                        .Date,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),

              MaterialButton(
                color: Colors.lightBlueAccent,
                onPressed: (!_estEnCoursDeChargement)
                    ? () async {
                  setState(() {
                    _estEnCoursDeChargement = true;
                  });
                  try {
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
                    await addTask(utilisateur!, _nomTache, selectedDate!);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Acceuil(),
                      ),
                    );
                  }  catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))));
                  }
                  finally {
                    setState(() {
                      _estEnCoursDeChargement = false;
                    });
                  }
                } : null,
                disabledColor: Colors.grey,
                child:
                _estEnCoursDeChargement ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 3,
                  ),
                ) : Text(S
                    .of(context)
                    .Ajouter,
                  style: TextStyle(color: Colors.black, fontSize: 20),),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
