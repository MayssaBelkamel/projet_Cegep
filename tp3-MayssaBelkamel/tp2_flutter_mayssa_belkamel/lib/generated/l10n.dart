// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get Connexion {
    return Intl.message('Login', name: 'Connexion', desc: '', args: []);
  }

  /// `Username`
  String get Pseudo {
    return Intl.message('Username', name: 'Pseudo', desc: '', args: []);
  }

  /// `Password`
  String get Mdp {
    return Intl.message('Password', name: 'Mdp', desc: '', args: []);
  }

  /// `Sign Up`
  String get Inscription {
    return Intl.message('Sign Up', name: 'Inscription', desc: '', args: []);
  }

  /// `Home`
  String get Accueil {
    return Intl.message('Home', name: 'Accueil', desc: '', args: []);
  }

  /// `No tasks available`
  String get pasDeTache {
    return Intl.message(
      'No tasks available',
      name: 'pasDeTache',
      desc: '',
      args: [],
    );
  }

  /// `Progress:`
  String get Avancement {
    return Intl.message('Progress:', name: 'Avancement', desc: '', args: []);
  }

  /// `Time:`
  String get Temps {
    return Intl.message('Time:', name: 'Temps', desc: '', args: []);
  }

  /// `Confirm password`
  String get confirm {
    return Intl.message(
      'Confirm password',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get Details {
    return Intl.message('Task Details', name: 'Details', desc: '', args: []);
  }

  /// `Due Date`
  String get Echeance {
    return Intl.message('Due Date', name: 'Echeance', desc: '', args: []);
  }

  // skipped getter for the '' key

  /// `Time elapsed`
  String get TempsDetail {
    return Intl.message(
      'Time elapsed',
      name: 'TempsDetail',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Enregistrer {
    return Intl.message('Save', name: 'Enregistrer', desc: '', args: []);
  }

  /// `Change image`
  String get changerImage {
    return Intl.message(
      'Change image',
      name: 'changerImage',
      desc: '',
      args: [],
    );
  }

  /// `Upload image`
  String get EnvoyerImage {
    return Intl.message(
      'Upload image',
      name: 'EnvoyerImage',
      desc: '',
      args: [],
    );
  }

  /// `Add a task`
  String get Ajouter {
    return Intl.message('Add a task', name: 'Ajouter', desc: '', args: []);
  }

  /// `Task name`
  String get nomTache {
    return Intl.message('Task name', name: 'nomTache', desc: '', args: []);
  }

  /// `Enter a date`
  String get Date {
    return Intl.message('Enter a date', name: 'Date', desc: '', args: []);
  }

  /// `Logout`
  String get Deconnexion {
    return Intl.message('Logout', name: 'Deconnexion', desc: '', args: []);
  }

  /// `Network error or not connected`
  String get ErrorWifi {
    return Intl.message(
      'Network error or not connected',
      name: 'ErrorWifi',
      desc: '',
      args: [],
    );
  }

  /// `The username is too short`
  String get nomCourt {
    return Intl.message(
      'The username is too short',
      name: 'nomCourt',
      desc: '',
      args: [],
    );
  }

  /// `The username is too long`
  String get nomLong {
    return Intl.message(
      'The username is too long',
      name: 'nomLong',
      desc: '',
      args: [],
    );
  }

  /// `Password should be at least 6 characters.`
  String get mdpCourt {
    return Intl.message(
      'Password should be at least 6 characters.',
      name: 'mdpCourt',
      desc: '',
      args: [],
    );
  }

  /// `The password is too long`
  String get mdpLong {
    return Intl.message(
      'The password is too long',
      name: 'mdpLong',
      desc: '',
      args: [],
    );
  }

  /// `The password and its confirmation do not match`
  String get mdpCofirm {
    return Intl.message(
      'The password and its confirmation do not match',
      name: 'mdpCofirm',
      desc: '',
      args: [],
    );
  }

  /// `This user already exists`
  String get nomExiste {
    return Intl.message(
      'This user already exists',
      name: 'nomExiste',
      desc: '',
      args: [],
    );
  }

  /// `Send the token`
  String get btnJetton {
    return Intl.message(
      'Send the token',
      name: 'btnJetton',
      desc: '',
      args: [],
    );
  }

  /// `Notfication test`
  String get btnNotification {
    return Intl.message(
      'Notfication test',
      name: 'btnNotification',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with google`
  String get google {
    return Intl.message(
      'Sign up with google',
      name: 'google',
      desc: '',
      args: [],
    );
  }

  /// `The task name can not be empty`
  String get titreTache {
    return Intl.message(
      'The task name can not be empty',
      name: 'titreTache',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get userExiste {
    return Intl.message(
      'The account already exists for that email.',
      name: 'userExiste',
      desc: '',
      args: [],
    );
  }

  /// `The email address is badly formatted.`
  String get mailFormat {
    return Intl.message(
      'The email address is badly formatted.',
      name: 'mailFormat',
      desc: '',
      args: [],
    );
  }

  /// `The email field can not be empty`
  String get nomVide {
    return Intl.message(
      'The email field can not be empty',
      name: 'nomVide',
      desc: '',
      args: [],
    );
  }

  /// `The password field can not be empty.`
  String get mdpVide {
    return Intl.message(
      'The password field can not be empty.',
      name: 'mdpVide',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
