import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';

class PanierSelectionneWidget extends StatelessWidget {
  final List<Map<String, dynamic>> donnees;
  final Function(Produit) supprimer;
  final Function() viderPanier;
  final Function() suivantCommande;
  const PanierSelectionneWidget({
    super.key,
    required this.donnees,
    required this.supprimer,
    required this.viderPanier,
    required this.suivantCommande
  });

  void confirmerSuppression(BuildContext context, Produit? p) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirmation"),
        content: Text("Etes-vous sûre ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              (p != null) ? supprimer(p) : viderPanier();
              Navigator.of(ctx).pop();
            },
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Produit> produitsSelectionnes = [];
    double total = 0;
    for (Map<String, dynamic> d in donnees) {
      produitsSelectionnes.add(d['produit']);
      total += (d['produit'].prixUnitaire) * (d['quantiteCommande']);
    }
    if (produitsSelectionnes.isEmpty) {
      return const Center(child: Text("Aucun produit sélectionné"));
    }
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (donnees.length > 1)
                  ? "Produits commandés :"
                  : "Produit commandé :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...donnees.map((d) {
              Produit p = d['produit'];
              double montant = p.prixUnitaire * d['quantiteCommande'];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                title: Text(
                  "${p.libelleProduit} (${d['quantiteCommande']} ${p.uniteMesure})",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text("${montant.toStringAsFixed(1)} Ar"),
                trailing: IconButton(
                  onPressed: () => confirmerSuppression(context, p),
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            }),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total à payer :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${total.toStringAsFixed(1)} Ar",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SimpleBouton(
                  texte: 'Vider mon panier',
                  transparent: true,
                  action: () => confirmerSuppression(context, null),
                ),
                SimpleBouton(
                  texte: 'Détails',
                  transparent: true,
                  action: () => {
                    Navigator.pushNamed(
                      context,
                      '/details-commande',
                      arguments: {
                        "donnees":donnees,
                        "viderPanier":() {
                          viderPanier();
                          Navigator.pop(context);
                        },
                        "suivantCommande":suivantCommande
                      },
                    ),
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
