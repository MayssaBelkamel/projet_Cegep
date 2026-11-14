
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> deleteTask(String userId, String taskId) async{
  try {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Tasks')
        .doc(taskId)
        .delete();
    print("Delete réussi");
  } catch (e) {
    print("Erreur lors du delete : $e");
    rethrow;
  }
}

Future<void> updateTask(String userId, String taskId, int nouvelAvancement) async {
  try {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Tasks')
        .doc(taskId)
        .update({
      'pourcentageAvancement': nouvelAvancement,
    });
    print("Mise à jour réussie !");
  } catch (e) {
    print("Erreur lors de la modification : $e");
    rethrow;
  }
}


void addUser(User user) async{
  CollectionReference userCollection= FirebaseFirestore.instance.collection('Users');
  userCollection.doc(user.uid).set({
    'uId':user.uid,
    'email':user.email
  });
}

 addTask(User user, String titre, DateTime date) async{
   List<QueryDocumentSnapshot> taches = [];
   taches=await getTasks(user);
   
  if(titre.trim().isEmpty){
throw Exception("Le titre de la tâche ne peut pas être vide.");
  }

  if(date.isBefore(DateTime.now())){
    throw Exception("La date seléctionnée doit être dans le futur.");
  }

 for(int i=0;i< taches.length;i++){
   final doc = taches[i];
   final tache = doc.data() as Map<String, dynamic>;
   var nomTache=tache['nom'] ?? 'Sans nom';

   if(nomTache.trim()==titre.trim()){
     throw Exception("Ce nom de tâche est déjà existant.");
   }
 }

  DateTime maintenant = DateTime.now();
  DateTime dateCreation = maintenant;

  int tempsTotalPrevu = date.difference(dateCreation).inMinutes;
  int tempsEcoule = maintenant.difference(dateCreation).inMinutes;

  double pourcentageTemps = tempsTotalPrevu > 0
      ? (tempsEcoule / tempsTotalPrevu) * 100
      : 0.0;
  CollectionReference userCollection= FirebaseFirestore.instance.collection('Users');
  userCollection.doc(user.uid).collection('Tasks').add({
    'nom':titre,
    'dateLimte':date.toString(),
    'pourcentageAvancement':0,
    'purcentageTempsEcoule': pourcentageTemps
  });
}


Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getTasks(User user) async {
  CollectionReference userCollection = FirebaseFirestore.instance.collection(
      'Users');
  var resultat = await userCollection.doc(user.uid).collection('Tasks').get();
  var tasksDocs=resultat.docs;
 return tasksDocs;
  //print(tasks);
}


