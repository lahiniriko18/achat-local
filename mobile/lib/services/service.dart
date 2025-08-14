import 'package:flutter/material.dart';

class Aliment{
  final String nom;
  final String chemin;

  Aliment(this.nom, this.chemin);
}

class MenuItem{
  final IconData icone;
  final String titre;
  final int index;
  final String url;

  MenuItem(this.icone, this.titre, this.index, this.url);
}

class MenuBouton {
  String texte;
  int index;
  MenuBouton(this.texte, this.index);

}

