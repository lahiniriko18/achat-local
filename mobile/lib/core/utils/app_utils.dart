import 'package:flutter/material.dart';

class Couleur{

  Color hexaToCouleur(String couleur){
    return Color(int.parse(couleur.replaceFirst('#', '0xff')));
  }
  String couleurEnHexa(Color couleur) {
    return '#${couleur.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  Color couleurMode(bool isDark){
    if (isDark) return Colors.white54;
    return Colors.black54;
  }
}