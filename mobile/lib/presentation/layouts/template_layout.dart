import 'package:flutter/material.dart';
import 'package:premier_app/presentation/widgets/sidebar_widget.dart';
import 'package:premier_app/presentation/widgets/header_widget.dart';

class TemplateLayout extends StatelessWidget {
  final Widget body;
  final String titre;
  final bool afficheRecherche;
  final String menuSelection;
  final Function()? rechercher;
  const TemplateLayout({
    super.key,
    required this.body,
    required this.titre,
    required this.afficheRecherche,
    required this.menuSelection,
    this.rechercher
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(titre: titre, afficheRecherche: afficheRecherche, menuSelection: menuSelection, rechercher: rechercher,),
      drawer: SidebarWidget(menuSelection: menuSelection,),
      body: body,
    );
  }
}
