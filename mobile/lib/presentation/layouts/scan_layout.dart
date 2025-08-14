import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/presentation/widgets/elements/chargement_widget.dart';
import 'package:premier_app/presentation/widgets/produit/produit_card_widget.dart';


class ScanLayout extends StatelessWidget {

  final Future<Produit> produit;
  final Function(Produit) setProduit;

  ScanLayout({super.key, required this.produit, required this.setProduit});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Produit>(
      future: produit,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Chargement();
        } else if (snapshot.hasError) {
          return Center(child: Text("Erreur : ${snapshot.error}"));
        } else if (!snapshot.hasData) {
          return Center(child: Text("Aucun Stock disponible"));
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setProduit(snapshot.data!);
          });
          return ProduitScancCard(produit: snapshot.data!);
        }
      },
    );
  }
}
