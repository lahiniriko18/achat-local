import 'package:flutter/material.dart';
import 'package:premier_app/presentation/layouts/template_layout.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/data/repositories/commande_repos.dart';
import 'package:premier_app/presentation/widgets/pages/commande/commande_widget.dart';

class CommandePage extends StatefulWidget {
  const CommandePage({super.key});

  @override
  State<StatefulWidget> createState() => CommandePageState();
}

class CommandePageState extends State<CommandePage> {
  final String nomPage = 'Commandes';
  List<Commande> commandes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    chargeCommande();
  }

  void chargeCommande() async {
    try {
      final cs = await CommandeRepos().tousCommandes();
      setState(() {
        commandes = cs;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
    }
  }

  void rechargeSuppression(int index) {
    setState(() {
      commandes.removeAt(index);
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
        body: CommandeWidget(
          commandes: commandes,
          rechargeSuppression: rechargeSuppression,
          isLoading: isLoading,
        ),
        titre: nomPage,
        afficheRecherche: true,
        menuSelection: nomPage,
        rechercher: () {
          if (isLoading) return null;
          Navigator.pushNamed(
            context,
            '/commande/recherche',
            arguments: {
              "commandes": commandes,
              "rechargeSuppression": rechargeSuppression,
            },
          );
        },
      ),
    );
  }
}
