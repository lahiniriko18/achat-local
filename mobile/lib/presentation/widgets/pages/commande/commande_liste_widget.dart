import 'package:flutter/material.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/core/utils/produit_utils.dart';
import 'package:premier_app/data/repositories/commande_repos.dart';
import 'package:premier_app/presentation/widgets/elements/chargement_widget.dart';
import 'package:premier_app/presentation/widgets/elements/card_table_widget.dart';

class CommandeListeWidget extends StatelessWidget {
  final List<Commande> commandes;
  final Function(int) rechargeSuppression;
  final bool isLoading;

  const CommandeListeWidget({
    super.key,
    required this.commandes,
    required this.rechargeSuppression,
    required this.isLoading,
  });

  void supprimer(BuildContext context, int index) async {
    try {
      await CommandeRepos().supprimerCommande(commandes[index].numCommande);
      rechargeSuppression(index);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Commande supprimé")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur : $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Chargement();
    } else {
      if (commandes.isEmpty) {
        return Center(child: Text("Aucun commande"));
      }
      else{
        return ListView.builder(
          itemCount: commandes.length,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          itemBuilder: (context, index) {
            final Commande commande = commandes[index];
            final List<Produit> produits = ProduitUtils.tousProduitsCommandes(
              commande.produits,
            );
            final int indexProduit = ProduitUtils.produitAyantImage(produits);
            Produit? p = (indexProduit != -1)
                ? commande.produits[indexProduit]['produit']
                : null;
            return CardTableWidget(
              titre: commande.client.nom,
              index: index,
              image: ((p != null) ? p.images[0] : null),
              sousTitre: commande.dateCommande.toString().split(".").first,
              supprimer: supprimer,
              details: () => Navigator.pushNamed(
                context,
                '/details',
                arguments: {"commande": commande},
              ),
            );
          },
        );
      }
    }
  }
}
