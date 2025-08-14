import 'package:flutter/material.dart';
import 'package:premier_app/data/models/client.dart';
import 'package:premier_app/presentation/widgets/pages/client/ajout_client_widget.dart';
import 'package:premier_app/presentation/layouts/detail_layout.dart';

class FormulaireClient extends StatelessWidget {
  final Client? clientInitial;
  final int? indexClientInitial;
  final Function(Client)? rechargeAjout;
  final Function(int, Client)? rechargeModif;

  const FormulaireClient({
    super.key,
    this.clientInitial,
    this.indexClientInitial,
    this.rechargeAjout,
    this.rechargeModif,
  });

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      body: FormulaireClientWidget(
        clientInitial: clientInitial,
        indexClientInitial: indexClientInitial,
        rechargeAjout: rechargeAjout,
        rechargeModif: rechargeModif,
      ),
      titre: clientInitial == null ? 'Ajout client' : 'Modifier client',
      menuSelection: 'Clients',
    );
  }
}
