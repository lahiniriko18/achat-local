import 'package:flutter/material.dart';
import 'package:premier_app/data/models/client.dart';
import 'package:premier_app/presentation/widgets/pages/client/client_liste_widget.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';

class ClientWidget extends StatelessWidget {
  final List<Client> clients;
  final Function(int) rechargeSuppression;
  final Function(int, Client) rechargeModif;
  final Function(Client) rechargeAjout;
  final bool isLoading;

  const ClientWidget({
    super.key,
    required this.clients,
    required this.rechargeSuppression,
    required this.rechargeModif,
    required this.isLoading,
    required this.rechargeAjout
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
                '/client/ajout',
                arguments: {"rechargeAjout": rechargeAjout},
              );
            },
          ),
          Expanded(
            child: ClientListeWidget(
              clients: clients,
              rechargeSuppression: rechargeSuppression,
              isLoading: isLoading,
              rechargeModif: rechargeModif,
            ),
          ),
        ],
      ),
    );
  }
}
