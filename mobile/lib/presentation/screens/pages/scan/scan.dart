import 'package:flutter/material.dart';
import 'package:premier_app/presentation/widgets/pages/scan/scan_widget.dart';
import 'package:premier_app/presentation/layouts/template_layout.dart';

class Scan extends StatelessWidget {
  const Scan({super.key});

  final String nomPage = 'Scan';

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
        body: ScanWidget(),
        titre: nomPage,
        afficheRecherche: false,
        menuSelection: nomPage,
      ),
    );
  }
}
