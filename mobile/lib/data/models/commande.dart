import 'package:premier_app/data/models/client.dart';
import 'package:premier_app/core/utils/produit_utils.dart';

class Commande {
  final int numCommande;
  final int numClient;
  final Client client;
  final List<Map<String, dynamic>> produits;
  final DateTime dateCommande;
  final String reference;

  Commande({
    required this.numCommande,
    required this.numClient,
    required this.client,
    required this.produits,
    required this.dateCommande,
    required this.reference,
  });

  factory Commande.fromJson(Map<String, dynamic> commande) {
    return Commande(
      numCommande: commande['numCommande'],
      numClient: commande['numClient'],
      client: Client.fromJson(commande['client']),
      produits: ProduitUtils.jsonProduitsCommandes(
        List<Map<String, dynamic>>.from(commande['produits']),
      ),
      dateCommande: DateTime.parse(commande['dateCommande']).toLocal(),
      reference: commande['reference'],
    );
  }
  String toSearchableString() {
    return '''
      ${client.nom}
      ${dateCommande.toString()}
      $reference
    '''
        .toLowerCase();
  }
}
