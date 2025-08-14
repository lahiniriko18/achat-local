import 'package:flutter/material.dart';
import 'package:premier_app/core/utils/produit_utils.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/data/models/produit.dart';

class CommandeCard extends StatelessWidget {
  final Commande commande;
  const CommandeCard({super.key, required this.commande});

  @override
  Widget build(BuildContext context) {
    int indexProduit = ProduitUtils.produitAyantImage(
      ProduitUtils.tousProduitsCommandes(commande.produits),
    );
    Produit? p = (indexProduit != -1)
        ? commande.produits[indexProduit]['produit']
        : null;
    final nbProduit = commande.produits.length;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/details',
            arguments: {
              'produits': commande.produits,
              'client': commande.client,
            },
          );
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        title: Text(
          commande.client.nom,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Text(
          commande.dateCommande.toString().split(".").first,
          style: TextStyle(fontSize: 14),
        ),
        leading: CircleAvatar(
          backgroundImage: (p != null)
              ? NetworkImage(p.images[0])
              : null,
          backgroundColor: Colors.transparent,
        ),
        trailing: Text(
          "${nbProduit.toString()} produit${(nbProduit > 1) ? 's' : ''}",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
