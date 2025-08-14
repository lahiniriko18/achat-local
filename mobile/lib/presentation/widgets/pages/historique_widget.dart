import 'package:flutter/material.dart';
import 'package:premier_app/presentation/widgets/pages/commande/commande_liste_widget.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/data/repositories/commande_repos.dart';

class HistoriqueWidget extends StatefulWidget {
  const HistoriqueWidget({super.key});

  @override
  State<HistoriqueWidget> createState() => HistoriquePage();
}

class HistoriquePage extends State<HistoriqueWidget> {
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
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
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
