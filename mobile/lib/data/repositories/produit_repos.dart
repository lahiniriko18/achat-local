import '../api/produit_api.dart';
import '../models/produit.dart';

class ProduitRepos {
  Future<List<Produit>> tousProduits() {
    return ProduitAPI().listeProduits();
  }

  Future<Produit> ajouterProduit(Map<String, dynamic> produit) {
    return ProduitAPI().ajoutProduit(produit);
  }

  Future<Produit> modifierProduit(
    Map<String, dynamic> produit,
    int numProduit,
  ) {
    return ProduitAPI().modifProduit(produit, numProduit);
  }

  Future<void> modifierMultipleProduit(List<int> numProduits) {
    return ProduitAPI().modifMultipleProduit(numProduits);
  }

  Future<Produit> uneProduit(String numProduit) {
    return ProduitAPI().uneProduit(numProduit);
  }

  Future<Produit> produitCommande() {
    return ProduitAPI().produitCommandeApi();
  }

  Future<bool> verifierProduit(int numProduit, int quantite) {
    return ProduitAPI().verifierProduitApi(numProduit, quantite);
  }

  Future<void> supprimerProduit(int numProduit) {
    return ProduitAPI().suppressionProduit(numProduit);
  }
}
