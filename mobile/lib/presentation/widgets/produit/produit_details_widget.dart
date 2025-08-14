import 'package:flutter/material.dart';
import 'package:premier_app/presentation/widgets/produit/produit_card_details_widget.dart';

class ProduitDetails extends StatelessWidget {

  final List<Map<String, dynamic>>  donnees;
  final List<Widget>? elements;
  const ProduitDetails({super.key, required this.donnees, this.elements});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: donnees.length + ((elements != null) ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < donnees.length){
          return Center(
            child: Produitcard(produit: donnees[index]['produit'],quantiteCommande: donnees[index]['quantiteCommande'],),
          );
        }
        else if(elements != null){
          return Column(
            children: elements!,
          );
        }
      },
    );
  }
}