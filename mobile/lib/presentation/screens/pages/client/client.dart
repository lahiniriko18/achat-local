import 'package:flutter/material.dart';
import 'package:premier_app/presentation/layouts/template_layout.dart';
import 'package:premier_app/data/models/client.dart';
import 'package:premier_app/data/repositories/client_repos.dart';
import 'package:premier_app/presentation/widgets/pages/client/client_widget.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<StatefulWidget> createState() => ClientPageState();
}

class ClientPageState extends State<ClientPage> {
  final String nomPage = 'Clients';
  List<Client> clients = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    chargeClient();
  }

  void chargeClient() async {
    try {
      final cs = await ClientRepos().tousClients();
      setState(() {
        clients = cs;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
    }
  }

  void rechargeSuppression(int index) {
    setState(() {
      clients.removeAt(index);
    });
  }

  void rechargeAjout(Client nouveauClient) {
    setState(() {
      clients.insert(0, nouveauClient);
    });
  }

  void rechargeModif(int index, Client nouveauClient) {
    setState(() {
      clients[index] = nouveauClient;
    });
  }

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
        body: ClientWidget(
          clients: clients,
          rechargeSuppression: rechargeSuppression,
          rechargeModif: rechargeModif,
          isLoading: isLoading,
          rechargeAjout: rechargeAjout,
        ),
        titre: nomPage,
        afficheRecherche: true,
        menuSelection: nomPage,
        rechercher: () {
          if (isLoading) return null;
          Navigator.pushNamed(
            context,
            '/client/recherche',
            arguments: {
              "clients": clients,
              "rechargeSuppression": rechargeSuppression,
              "rechargeModif": rechargeModif,
            },
          );
        },
      ),
    );
  }
}
