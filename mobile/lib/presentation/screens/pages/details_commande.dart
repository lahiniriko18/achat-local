import 'package:flutter/material.dart';
import 'package:premier_app/presentation/layouts/detail_layout.dart';
import 'package:premier_app/presentation/widgets/pages/scan/details_commande_widget.dart';

class DetailsCommande extends StatelessWidget {
  final List<Map<String, dynamic>>  donnees;
  final Function() viderPanier;
  final Function() suivantCommande;
  const DetailsCommande({super.key, required this.donnees, required this.viderPanier, required this.suivantCommande});

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      body: DetailsCommandeWidget(donnees: donnees, viderPanier: viderPanier,suivantCommande: suivantCommande,),
      titre: 'Détails',
      menuSelection: 'Scan',
    );
  }
}
