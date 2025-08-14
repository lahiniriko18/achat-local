import 'package:flutter/material.dart';
import 'package:premier_app/presentation/widgets/pages/accueil_widget.dart';
import 'package:premier_app/presentation/layouts/template_layout.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  final String nomPage = 'Accueil';

  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
      body: AccueilWidget(),
      titre: nomPage,
      afficheRecherche: false,
      menuSelection: nomPage,
    );
  }
}
