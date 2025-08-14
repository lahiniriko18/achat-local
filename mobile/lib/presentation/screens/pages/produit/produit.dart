import 'package:flutter/material.dart';
import 'package:premier_app/presentation/layouts/template_layout.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/data/repositories/produit_repos.dart';
import 'package:premier_app/presentation/widgets/pages/produit/produit_widget.dart';

class ProduitPage extends StatefulWidget {
  const ProduitPage({super.key});

  @override
  State<StatefulWidget> createState() => ProduitPageState();
}

class ProduitPageState extends State<ProduitPage> {
  final String nomPage = 'Produits';
  List<Produit> produits = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    chargeProduit();
  }

  void chargeProduit() async {
    try {
      final cs = await ProduitRepos().tousProduits();
      setState(() {
        produits = cs;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
    }
  }

  void rechargeSuppression(int index) {
    setState(() {
      produits.removeAt(index);
    });
  }

  void rechargeAjout(Produit nouveauProduit) {
    setState(() {
      produits.insert(0, nouveauProduit);
    });
  }

  void rechargeModif(int index, Produit nouveauProduit) {
    setState(() {
      produits[index] = nouveauProduit;
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
        body: ProduitWidget(
          produits: produits,
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
            '/produit/recherche',
            arguments: {
              "produits": produits,
              "rechargeSuppression": rechargeSuppression,
              "rechargeModif": rechargeModif
            },
          );
        },
      ),
    );
  }
}
