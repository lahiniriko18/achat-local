import 'package:premier_app/services/service.dart';
import 'package:flutter/material.dart';

class MenutItems {
  static List<MenuItem> menus = [
    MenuItem(Icons.home, 'Accueil', 0, '/'),
    MenuItem(Icons.add_a_photo, 'Scan', 1, '/scan'),
    MenuItem(Icons.history, 'Historique', 2, '/historique'),
    MenuItem(Icons.settings, 'Paramètre', 3, '/parametre'),
  ];

}