import 'package:flutter/material.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/presentation/widgets/pages/details_widget.dart';
import 'package:premier_app/presentation/layouts/detail_layout.dart';

class Details extends StatelessWidget {
  final Commande commande;
  const Details({super.key, required this.commande});

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      body: DetailsWidget(commande: commande,),
      titre: 'Détails',
      menuSelection: 'Historique',
    );
  }
}
