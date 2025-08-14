import 'package:premier_app/data/models/produit.dart';

import '../api/categorie_api.dart';
import '../models/categorie.dart';

class CategorieRepos {
  Future<List<Categorie>> tousCategories() {
    return CategorieAPI().listeCategories();
  }

  Future<Categorie> ajouterCategorie(Map<String, dynamic> donne) {
    return CategorieAPI().ajoutCategorie(donne);
  }

  Future<Categorie> modifierCategorie(
    Map<String, dynamic> donne,
    int numCategorie,
  ) {
    return CategorieAPI().modifCategorie(donne, numCategorie);
  }

  Future<Categorie> uneCategorie(String numCategorie) {
    return CategorieAPI().uneCategorie(numCategorie);
  }

  Future<List<Produit>> produitCategorie(int numCategorie) {
    return CategorieAPI().listeProduitCategorie(numCategorie);
  }

  Future<void> supprimerCategorie(int numCategorie) {
    return CategorieAPI().suppressionCategorie(numCategorie);
  }
}
