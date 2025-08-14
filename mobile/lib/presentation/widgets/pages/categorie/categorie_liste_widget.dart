import 'package:flutter/material.dart';
import 'package:premier_app/data/models/categorie.dart';
import 'package:premier_app/data/repositories/categorie_repos.dart';
import 'package:premier_app/presentation/widgets/elements/chargement_widget.dart';
import 'package:premier_app/presentation/widgets/elements/card_table_widget.dart';

class CategorieListeWidget extends StatelessWidget {
  final List<Categorie> categories;
  final Function(int) rechargeSuppression;
  final Function(int, Categorie) rechargeModif;
  final bool isLoading;

  const CategorieListeWidget({
    super.key,
    required this.categories,
    required this.rechargeSuppression,
    required this.rechargeModif,
    required this.isLoading,
  });

  void supprimer(BuildContext context, int index) async {
    try {
      await CategorieRepos().supprimerCategorie(categories[index].numCategorie);
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
      if (categories.isEmpty) {
        return Center(child: Text("Aucun catégorie"));
      } else {
        return ListView.builder(
          itemCount: categories.length,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          itemBuilder: (context, index) {
            final Categorie categorie = categories[index];
            final image = categorie.imageCategorie;
            return CardTableWidget(
              titre: categorie.nomCategorie,
              index: categorie.numCategorie,
              image: (image),
              supprimer: supprimer,
              modification: () {
                Navigator.pushNamed(
                  context,
                  '/categorie/modifier',
                  arguments: {
                    "categorieInitial": categorie,
                    "indexCategorieInitial": index,
                    "rechargeModif": rechargeModif,
                  },
                );
              },
              details: () {
                Navigator.pushNamed(
                  context,
                  '/categorie/details',
                  arguments: {"categorie": categorie},
                );
              },
            );
          },
        );
      }
    }
  }
}
