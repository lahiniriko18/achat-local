import 'package:flutter/material.dart';
import 'package:premier_app/presentation/layouts/template_layout.dart';
import 'package:premier_app/data/models/categorie.dart';
import 'package:premier_app/data/repositories/categorie_repos.dart';
import 'package:premier_app/presentation/widgets/pages/categorie/categorie_widget.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({super.key});

  @override
  State<StatefulWidget> createState() => CategorieState();
}

class CategorieState extends State<CategoriePage> {
  final String nomPage = 'Categories';
  List<Categorie> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    chargeCategorie();
  }

  void chargeCategorie() async {
    try {
      final cs = await CategorieRepos().tousCategories();
      setState(() {
        categories = cs;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
    }
  }

  void rechargeSuppression(int index) {
    setState(() {
      categories.removeAt(index);
    });
  }

  void rechargeAjout(Categorie nouveauCategorie) {
    setState(() {
      categories.insert(0, nouveauCategorie);
    });
  }

  void rechargeModif(int index, Categorie nouveauCategorie) {
    setState(() {
      categories[index] = nouveauCategorie;
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
        body: CategorieWidget(
          categories: categories,
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
            '/categorie/recherche',
            arguments: {
              "categories": categories,
              "rechargeSuppression": rechargeSuppression,
              "rechargeModif": rechargeModif
            },
          );
        },
      ),
    );
  }
}
