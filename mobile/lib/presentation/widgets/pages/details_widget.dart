import 'package:flutter/material.dart';
import 'package:premier_app/core/utils/commande_utils.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/presentation/widgets/produit/produit_details_widget.dart';
import 'package:premier_app/presentation/widgets/elements/listage_widget.dart';

class DetailsWidget extends StatelessWidget {
  final Commande commande;
  const DetailsWidget({
    super.key,
    required this.commande,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> produits = commande.produits;
    return Column(
      children: [
        Container(
          height: 60,
          child: Center(
            child: Text(
              "Produit${produits.length > 1 ? 's' : ''} commandé${produits.length > 1 ? 's' : ''} par ${commande.client.nom}",
            ),
          ),
        ),
        Expanded(
          child: ProduitDetails(
            donnees: produits,
            elements: [
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Center(
                  child: Column(
                    children: [
                      ListageWidget(
                        titre: "Nombre des produits :",
                        valeur: produits.length.toString(),
                      ),
                      ListageWidget(
                        titre: "Montant à payer :",
                        valeur: "${CommandeUtils.montantPayer(produits)} Ar",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
