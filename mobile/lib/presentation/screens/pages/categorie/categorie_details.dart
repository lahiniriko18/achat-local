import 'package:flutter/material.dart';
import 'package:premier_app/data/models/categorie.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/data/repositories/categorie_repos.dart';
import 'package:premier_app/presentation/layouts/detail_layout.dart';
import 'package:premier_app/presentation/widgets/pages/categorie/categorie_details_widget.dart';

class CategorieDetails extends StatefulWidget {
  final Categorie categorie;
  const CategorieDetails({super.key, required this.categorie});

  @override
  State<CategorieDetails> createState() => CategorieDetailsState();
}

class CategorieDetailsState extends State<CategorieDetails> {
  List<Produit> produits = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    chargeProduits();
  }

  void chargeProduits() async {
    try {
      final ps = await CategorieRepos().produitCategorie(
        widget.categorie.numCategorie,
      );
      setState(() {
        isLoading = false;
        produits = ps;
      });
    } catch (e) {
      print("Erreur : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      body: Center(
        child: DetailsCategorieWidget(
          donnees: {"categorie": widget.categorie, "produits": produits},
          isLoading: isLoading,
        ),
      ),
      titre: 'Détails',
      menuSelection: 'Categories',
    );
  }
}
