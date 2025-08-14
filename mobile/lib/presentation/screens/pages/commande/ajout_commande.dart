import 'package:flutter/material.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/presentation/widgets/pages/Commande/ajout_Commande_widget.dart';
import 'package:premier_app/presentation/layouts/detail_layout.dart';

class AjoutCommande extends StatelessWidget {
  const AjoutCommande({super.key});

  void ajoutCommande(Commande commande) async {
  }

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      body: FormulaireCommandeWidget(onSubmit: ajoutCommande),
      titre: 'Ajout commande',
      menuSelection: 'Commandes',
    );
  }
}
