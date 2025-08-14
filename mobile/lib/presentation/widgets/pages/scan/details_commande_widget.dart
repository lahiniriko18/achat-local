import 'package:flutter/material.dart';
import 'package:premier_app/core/utils/commande_utils.dart';
import 'package:premier_app/presentation/widgets/produit/produit_details_widget.dart';
import 'package:premier_app/presentation/widgets/elements/listage_widget.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';

class DetailsCommandeWidget extends StatelessWidget {
  final List<Map<String, dynamic>>  donnees;
  final Function() viderPanier;
  final Function() suivantCommande;
  const DetailsCommandeWidget({
    super.key,
    required this.donnees,
    required this.viderPanier,
    required this.suivantCommande,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 50, child: Center(child: Text("Commande en cours"))),
        Expanded(
          child: ProduitDetails(
            donnees: donnees,
            elements: [
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Center(
                  child: Column(
                    children: [
                      ListageWidget(
                        titre: "Nombre des produits :",
                        valeur: donnees.length.toString(),
                      ),
                      ListageWidget(
                        titre: "Montant à payer :",
                        valeur: "${CommandeUtils.montantPayer(donnees)} Ar",
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SimpleBouton(texte: "Vider mon panier", action: viderPanier),
                  SimpleBouton(texte: "Suivant", action: suivantCommande),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
