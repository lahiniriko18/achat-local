import 'package:premier_app/data/models/commande.dart';
import 'package:flutter/material.dart';
import 'package:premier_app/presentation/widgets/elements/dialog_widget.dart';

class CommandeUtils {
  // static List<Commande> jsonVersModel(List<dynamic> donnee) {
  //   return donnee.map((json) => Commande.fromJson(json)).toList();
  // }

  static double montantPayer(List<Map<String, dynamic>> donnees) {
    double total = 0;
    for (Map<String, dynamic> d in donnees) {
      total += (d['produit'].prixUnitaire) * (d['quantiteCommande']);
    }
    return total;
  }

  static void suivantCommande(
    BuildContext context,
    Function chargeDonneCommande,
    List<Map<String, dynamic>> produitsCommandes,
  ) {
    chargeDonneCommande();
    if (produitsCommandes.isNotEmpty) {
      Navigator.pushNamed(
        context,
        '/commande/client',
        arguments: {"produitsCommandes": produitsCommandes},
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => MessageDialog(
          titre: "Panier vide",
          message: "Veuillez sélectionner au moins une produit",
        ),
      );
    }
  }
}
