import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/data/repositories/produit_repos.dart';
import 'package:premier_app/presentation/widgets/elements/chargement_widget.dart';
import 'package:premier_app/presentation/widgets/elements/card_table_widget.dart';

class ProduitListeWidget extends StatelessWidget {
  final List<Produit> produits;
  final Function(int) rechargeSuppression;
  final Function(int, Produit) rechargeModif;
  final bool isLoading;

  const ProduitListeWidget({
    super.key,
    required this.produits,
    required this.rechargeSuppression,
    required this.rechargeModif,
    required this.isLoading,
  });

  void supprimer(BuildContext context, int index) async {
    try {
      await ProduitRepos().supprimerProduit(produits[index].numProduit);
      rechargeSuppression(index);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Produit supprimé")));
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
      if (produits.isEmpty) {
        return Center(child: Text("Aucun produit"));
      } else {
        return ListView.builder(
          itemCount: produits.length,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          itemBuilder: (context, index) {
            final Produit produit = produits[index];
            final images = produit.images;
            return CardTableWidget(
              titre: "${produit.libelleProduit} (${produit.prixUnitaire} Ar)",
              index: index,
              sousTitre: "${produit.quantite}",
              image: (images.isNotEmpty ? images[0] : ''),
              supprimer: supprimer,
              modification: () {
                Navigator.pushNamed(
                  context,
                  '/produit/modifier',
                  arguments: {
                    "produitInitial": produit,
                    "indexProduitInitial": index,
                    "rechargeModif":rechargeModif
                  },
                );
              },
              details: () => Navigator.pushNamed(
                context,
                '/produit/details',
                arguments: {"produit": produit},
              ),
            );
          },
        );
      }
    }
  }
}
