import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Config with ChangeNotifier {
  bool isDarks = false;
  String themes = '#2196F3';
  double taillePolices = 18.0;
  String access = '';
  String refreshs = '';
  Color couleurTextes = Colors.black54;
  List<String> historiqueRecherches = [];

  bool get isDark => isDarks;
  double get taillePolice => taillePolices;
  String get theme => themes;
  String get accessToken => access;
  String get refresh => refreshs;
  Color get couleurTexte => isDarks ? Colors.white54 : couleurTextes;
  List<String> get recherches => historiqueRecherches;

  Config() {
    chargePreference();
  }

  Future<void> chargePreference() async {
    final preference = await SharedPreferences.getInstance();
    isDarks = preference.getBool('mode') ?? false;
    themes = preference.getString('theme') ?? "#2196F3";
    taillePolices = preference.getDouble('taillePolice') ?? 18.0;
    access = preference.getString('accessToken') ?? '';
    refreshs = preference.getString('refresh') ?? '';
    historiqueRecherches = preference.getStringList('recherches') ?? [];
    notifyListeners();
  }

  Future<void> setAccess(String accessToken) async {
    access = accessToken;
    final preference = await SharedPreferences.getInstance();
    await preference.setString('accessToken', accessToken);
    notifyListeners();
  }

  Future<void> setRefresh(String refresh) async {
    refreshs = refresh;
    final preference = await SharedPreferences.getInstance();
    await preference.setString('refresh', refresh);
    notifyListeners();
  }

  Future<void> setTaillePolice(double taille) async {
    taillePolices = taille;
    final preference = await SharedPreferences.getInstance();
    await preference.setDouble('taillePolice', taille);
    notifyListeners();
  }

  Future<void> setDarkMode(bool darkMode) async {
    isDarks = darkMode;
    final preference = await SharedPreferences.getInstance();
    await preference.setBool('mode', darkMode);
    notifyListeners();
  }

  Future<void> setTheme(String couleur) async {
    themes = couleur;
    final preference = await SharedPreferences.getInstance();
    await preference.setString('theme', couleur);
    notifyListeners();
  }

  Future<void> ajouterRecherche(String valeur) async {
    valeur = valeur.trim();

    if (valeur.isEmpty ||
        (historiqueRecherches.isNotEmpty &&
            historiqueRecherches.first == valeur))
      return;

    historiqueRecherches.remove(valeur);
    historiqueRecherches.insert(0, valeur);

    if (historiqueRecherches.length > 8) {
      historiqueRecherches = historiqueRecherches.sublist(0, 8);
    }

    final preference = await SharedPreferences.getInstance();
    await preference.setStringList('recherches', historiqueRecherches);

    notifyListeners();
  }

  Future<void> effacerRecherches() async {
    historiqueRecherches.clear();
    final preference = await SharedPreferences.getInstance();
    await preference.remove('recherches');
    notifyListeners();
  }
}
