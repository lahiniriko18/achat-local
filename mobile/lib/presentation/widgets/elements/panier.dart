import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';


class Panier extends StatelessWidget {
  final List<Produit> produits;
  final Function() viderPanier;

  Panier({super.key, required this.produits, required this.viderPanier});

  @override
  Widget build(BuildContext context) {
    int nbProduit = produits.length;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: (){
            if(nbProduit > 0){
              Navigator.pushNamed(
                  context,
                  '/details-commande',
                  arguments: {
                    'produits': produits,
                    'viderPanier': viderPanier
                  }
              );
            }
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              width: 80,
              height: 80,
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/panier.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          right: -4,
          top: -4,
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Text(
              produits.length.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold
              )
            ),
          ),
        ),
      ],
    );
  }
}