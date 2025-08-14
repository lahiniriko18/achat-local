import 'package:flutter/material.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/presentation/widgets/pages/commande/commande_liste_widget.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';

class CommandeWidget extends StatelessWidget {
  final List<Commande> commandes;
  final Function(int) rechargeSuppression;
  final bool isLoading;

  const CommandeWidget({
    super.key,
    required this.commandes,
    required this.rechargeSuppression,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 10),
          SimpleBouton(
            texte: 'Ajouter',
            icone: Icon(Icons.add, color: Colors.white),
            action: () {
              Navigator.pushNamed(
                context,
                '/commande/ajout',
              );
            },
          ),
          Expanded(
            child: CommandeListeWidget(
              commandes: commandes,
              rechargeSuppression: rechargeSuppression,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
