import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';

class ProduitScancCard extends StatelessWidget {
  final Produit produit;
  const ProduitScancCard({super.key, required this.produit});

  @override
  Widget build(BuildContext context) {
    final images = produit.images;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () {
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        title: Text(
          produit.libelleProduit,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        leading: CircleAvatar(
          backgroundImage: (images.isNotEmpty)
              ? NetworkImage(images[0])
              : null,
          backgroundColor: Colors.transparent,
        ),
        trailing: Text(
          "${produit.prixUnitaire} Ar",
          style: TextStyle(
              fontSize: 16
          ),
        ),
      ),
    );
  }
}