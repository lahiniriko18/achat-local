import 'package:flutter/material.dart';
import 'package:premier_app/presentation/widgets/simple_appbar.dart';

class DetailLayout extends StatelessWidget {
  final Widget body;
  final String titre;
  final String menuSelection;
  const DetailLayout({
    super.key,
    required this.body,
    required this.titre,
    required this.menuSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(titre: titre, menuSelection: menuSelection,),
      body: body,
    );
  }
}
