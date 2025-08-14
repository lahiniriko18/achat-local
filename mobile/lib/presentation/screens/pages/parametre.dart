import 'package:flutter/material.dart';
import 'package:premier_app/presentation/widgets/pages/parametre_widget.dart';
import 'package:premier_app/presentation/layouts/template_layout.dart';

class Parametre extends StatelessWidget {
  const Parametre({super.key});

  final String nomPage = 'Paramètre';
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
        body: ParametreWidget(themeCouleur: Theme.of(context).primaryColor),
        titre: nomPage,
        afficheRecherche: false,
        menuSelection: nomPage,
      ),
    );
  }
}
