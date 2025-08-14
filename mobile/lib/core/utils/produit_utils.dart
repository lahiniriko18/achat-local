import 'package:premier_app/data/models/produit.dart';

class ProduitUtils {
  static List<Produit> jsonVersModel(List<dynamic> donnee) {
    return donnee.map((json) => Produit.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> jsonProduitsCommandes(List<Map<String, dynamic>> donnees) {
    List<Map<String, dynamic>> produits = [];
    for (Map<String, dynamic> d in donnees) {
      produits.add({
        "produit":Produit.fromJson(d['produit']),
        "quantiteCommande":d['quantiteCommande']
      });
    }
    return produits;
  }

  static List<Produit> tousProduitsCommandes(List<Map<String, dynamic>> donnees) {
    List<Produit> produits = [];
    for (Map<String, dynamic> d in donnees) {
      produits.add(d['produit']);
    }
    return produits;
  }
  static List<String> dynamicToString(List<dynamic> donnee) {
    return donnee.map((e) => e.toString()).toList();
  }

  static double sommePrix(List<Produit> produits) {
    double somme = 0;
    produits.forEach((produit) {
      somme += produit.prixUnitaire;
    });
    return somme;
  }

  static int produitAyantImage(List<Produit> produits) {
    return produits.indexWhere((p) => p.images.isNotEmpty);
  }

  static int existePanier(List<Map<String, dynamic>> donnees, Produit produit) {
    for (var e in donnees.asMap().entries) {
      int index = e.key;
      Map<String, dynamic> d = e.value;
      Produit p = d['produit'];
      if (p.numProduit == produit.numProduit) return index;
    }
    return -1;
  }
}
