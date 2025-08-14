import 'package:flutter/material.dart';
import 'package:premier_app/presentation/layouts/detail_layout.dart';
import 'package:premier_app/presentation/widgets/pages/commande/ajout_client_commande_widget.dart';

class FormulaireClientCommade extends StatelessWidget {
  final List<Map<String, dynamic>> produitsCommandes;

  const FormulaireClientCommade({super.key, required this.produitsCommandes});

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      body: FormulaireClientCommandeWidget(produitsCommandes: produitsCommandes),
      titre: 'Ajout commande',
      menuSelection: 'Commandes',
    );
  }
}
