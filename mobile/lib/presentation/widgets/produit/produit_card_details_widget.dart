import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/presentation/widgets/elements/listage_widget.dart';

class Produitcard extends StatelessWidget {
  final Produit produit;
  final double? quantiteCommande;

  const Produitcard({super.key, required this.produit, this.quantiteCommande});

  @override
  Widget build(BuildContext context) {
    final images = produit.images;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: SizedBox(
                width: 150,
                height: 150,
                child: (images.isNotEmpty)
                    ? Image.network(images[0], fit: BoxFit.cover)
                    : Image.asset(
                        'assets/images/default-produit.jpeg',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            ListageWidget(titre: "Nom :", valeur: produit.libelleProduit),
            ListageWidget(
              titre: "Prix unitaire :",
              valeur: "${produit.prixUnitaire} Ar",
            ),
            ListageWidget(
              titre: "Quantité disponible :",
              valeur: "${produit.quantite} ${produit.uniteMesure}",
            ),
            ListageWidget(
              titre: "Catégorie :",
              valeur: "${produit.categorie?.nomCategorie}",
            ),
            if (quantiteCommande != null)
              Column(
                children: [
                  ListageWidget(
                    titre: "Quantité commandé :",
                    valeur: "$quantiteCommande ${produit.uniteMesure}",
                  ),
                  ListageWidget(
                    titre: "Prix total :",
                    valeur: "${quantiteCommande! * produit.prixUnitaire} Ar",
                  ),
                ],
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
