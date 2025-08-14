import 'package:flutter/material.dart';
import 'package:premier_app/data/models/client.dart';
import 'package:premier_app/presentation/widgets/elements/chargement_widget.dart';
import 'package:premier_app/presentation/widgets/elements/card_table_widget.dart';
import 'package:premier_app/data/repositories/client_repos.dart';

class ClientListeWidget extends StatelessWidget {
  final List<Client> clients;
  final Function(int) rechargeSuppression;
  final Function(int, Client) rechargeModif;
  final bool isLoading;

  const ClientListeWidget({
    super.key,
    required this.clients,
    required this.rechargeSuppression,
    required this.rechargeModif,
    required this.isLoading,
  });

  void supprimer(BuildContext context, int index) async {
    try {
      await ClientRepos().supprimerClient(clients[index].numClient);
      rechargeSuppression(index);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Client supprimé")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur : $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Chargement();
    } else {
      if (clients.isEmpty) {
        return Center(child: Text("Aucun client"));
      } else {
        return ListView.builder(
          itemCount: clients.length,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          itemBuilder: (context, index) {
            final Client client = clients[index];
            final String? contact = (client.contact != null ) ? client.contact!
                .replaceFirst('+261', '')
                .trim()
                .replaceAll(' ', ''): null;
            Client nouveauClient = Client(
              numClient: client.numClient,
              nom: client.nom,
              contact: contact,
              adresse: client.adresse
            );
            return CardTableWidget(
              titre: client.nom,
              index: index,
              sousTitre: client.contact,
              supprimer: supprimer,
              modification: () {
                Navigator.pushNamed(
                  context,
                  '/client/modifier',
                  arguments: {
                    "clientInitial": nouveauClient,
                    "indexClientInitial": index,
                    "rechargeModif":rechargeModif
                  },
                );
              },
            );
          },
        );
      }
    }
  }
}
