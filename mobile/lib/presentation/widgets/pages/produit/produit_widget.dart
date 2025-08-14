import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/presentation/widgets/produit/produit_liste_widget.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';

class ProduitWidget extends StatelessWidget {
  final List<Produit> produits;
  final Function(int) rechargeSuppression;
  final Function(int, Produit) rechargeModif;
  final Function(Produit) rechargeAjout;
  final bool isLoading;

  const ProduitWidget({
    super.key,
    required this.produits,
    required this.rechargeSuppression,
    required this.rechargeModif,
    required this.isLoading,
    required this.rechargeAjout
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 10),
          SimpleBouton(
            texte: 'Ajouter',
            icone: Icon(Icons.add, color: Colors.white),
            action: () {
              Navigator.pushNamed(
                context,
                '/produit/ajout',
                arguments: {"rechargeAjout": rechargeAjout},
              );
            },
          ),
          Expanded(
            child: ProduitListeWidget(
              produits: produits,
              rechargeSuppression: rechargeSuppression,
              isLoading: isLoading,
              rechargeModif: rechargeModif,
            ),
          ),
        ],
      ),
    );
  }
}
