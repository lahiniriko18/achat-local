import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/presentation/layouts/detail_layout.dart';
import 'package:premier_app/presentation/widgets/produit/produit_card_details_widget.dart';

class UneProduitDetails extends StatelessWidget {
  final Produit produit;
  const UneProduitDetails({super.key, required this.produit});

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      body: Center(child: Produitcard(produit: produit)),
      titre: 'Détails',
      menuSelection: 'Produits',
    );
  }
}
