import '../api/commande_api.dart';
import '../models/commande.dart';

class CommandeRepos {
  Future<List<Commande>> tousCommandes() {
    return CommandeAPI().listeCommandes();
  }

  Future<Commande> ajouterCommande(Map<String, dynamic> donnee) {
    return CommandeAPI().ajoutCommande(donnee);
  }

  Future<Commande> dernierCommande() {
    return CommandeAPI().dernierCommandeApi();
  }

  Future<void> supprimerCommande(int numCommande) {
    return CommandeAPI().suppressionCommande(numCommande);
  }
}
