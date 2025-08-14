import 'package:flutter/material.dart';
import 'package:premier_app/presentation/widgets/pages/historique_widget.dart';
import 'package:premier_app/presentation/layouts/template_layout.dart';

class Historique extends StatelessWidget {
  const Historique({super.key});

  final String nomPage = 'Historique';
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      },
      child: TemplateLayout(
        body: HistoriqueWidget(),
        titre: nomPage,
        afficheRecherche: true,
        menuSelection: nomPage,
        rechercher: () {
          print("Mety");
        },
      ),
    );
  }
}
