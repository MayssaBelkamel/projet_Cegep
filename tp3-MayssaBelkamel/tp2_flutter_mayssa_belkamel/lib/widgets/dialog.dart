import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

void afficherDialogueErreur(BuildContext context, VoidCallback onReessayer) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.signal_wifi_connected_no_internet_4, color: Colors.red),
            const SizedBox(width: 10),
            const Text("Erreur"),
          ],
        ),
        content: Text(S.of(context).ErrorWifi),
        actions: [

          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Annuler", style: TextStyle(color: Colors.grey)),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
            onPressed: () {
              onReessayer();
              Navigator.of(context).pop();

            },
            child: const Text("Réessayer", style: TextStyle(color: Colors.black)),
          ),
        ],
      );
    },
  );
}
