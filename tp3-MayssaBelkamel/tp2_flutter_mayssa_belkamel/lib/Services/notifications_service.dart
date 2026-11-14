import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tp1_flutter_mayssabelkamel/pages/Acceuil.dart';

import '../pages/main.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> setupFirebaseMessaging() async {
  print("=== FCM : Initialisation du service de notifications ===");

  // TODO #11 : Initialiser le gestionnaire de notifications
  await flutterLocalNotificationsPlugin.initialize(
    settings: const InitializationSettings(
        android: AndroidInitializationSettings('@android:drawable/ic_dialog_info')),
    // TODO #15.1 : Réaction au clic sur une notification lorsque l'application est ouverte
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      print("=== CLIC : Détecté en PREMIER PLAN (Foreground) ===");
      if (response.payload != null) {
        handleForegroundNotificationClick(response.payload!);
      }
    },
  );

  // TODO #12 : Demander la permission à l'utilisateur pour lui envoyer des notifications (Ajout de await)
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Demander explicitement la permission au plugin local pour Android 13+
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  // TODO #13 : Réception des notifications lorsque l'application est ouverte
  FirebaseMessaging.onMessage.listen((message) {
    print("=== MESSAGE REÇU : L'application est ouverte, appel de _showNotification ===");
    _showNotification(message);
  });

  // TODO #15.2 : Réaction au clic sur une notification lorsque l'application est en arrière-plan
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print("=== CLIC : Détecté en ARRIÈRE-PLAN (Background) ===");
    handleBackgroundNotificationClick(message);
  });

  // TODO #15.3 : Réaction au clic sur une notification lorsque l'application est complètement fermée
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      print("=== CLIC : L'application était FERMÉE, ouverture via notification ===");
      handleBackgroundNotificationClick(message);
    }
  });
}

Future<void> _showNotification(RemoteMessage message) async {
  print("-> _showNotification appelée !");
  print("-> Titre reçu du serveur : ${message.notification?.title}");
  print("-> Corps reçu du serveur : ${message.notification?.body}");
  print("-> Données payload (data) : ${message.data}");

  // TODO #14 RECTIFIÉ : Syntaxe 100% nommée exigée par votre version du package
  await flutterLocalNotificationsPlugin.show(
    id: message.notification?.hashCode ?? 0,
    title: message.notification?.title ?? 'Notification',
    body: message.notification?.body ?? 'Vous avez reçu une notification.',
    notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'kickmyb_tasks_channel',
          'Rappels de tâches',
          channelDescription: 'Canal d\'envoi pour les rappels de tâches',
          importance: Importance.max,   // Forcer la bannière pop-up
          priority: Priority.high,       // Forcer la bannière pop-up
        )),
    payload: message.data['OrderContent'] ?? 'default',
  );
  print("-> Appel à flutterLocalNotificationsPlugin.show terminé !");
}


// TODO #16.1 : Ce qu'on fait quand on a cliqué sur une notification en arrière-plan
void handleBackgroundNotificationClick(RemoteMessage? message) {
  print("-> handleBackgroundNotificationClick appelée !");
  if (message == null) return;

  Navigator.push(
    navigatorKey.currentContext!,
    MaterialPageRoute(
        builder: (context) => const Acceuil()
    ),
  );
}

// TODO #16.2 : Ce qu'on fait quand on a cliqué sur une notification alors que l'application était ouverte
Future<void> handleForegroundNotificationClick(String payload) async {
  print("-> handleForegroundNotificationClick appelée avec le payload : $payload");
  await Navigator.push(
    navigatorKey.currentContext!,
    MaterialPageRoute(
        builder: (context) => const Acceuil()
    ),
  );
}
