import 'package:flutter/material.dart';
import 'package:premier_app/data/models/categorie.dart';
import 'package:premier_app/presentation/widgets/pages/categorie/ajout_categorie_widget.dart';
import 'package:premier_app/presentation/layouts/detail_layout.dart';

class FormulaireCategorie extends StatelessWidget {
  final Categorie? categorieInitial;
  final int? indexCategorieInitial;
  final Function(Categorie)? rechargeAjout;
  final Function(int, Categorie)? rechargeModif;

  const FormulaireCategorie({
    super.key,
    this.categorieInitial,
    this.indexCategorieInitial,
    this.rechargeAjout,
    this.rechargeModif,
  });

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      body: FormulaireCategorieWidget(
        categorieInitial: categorieInitial,
        indexCategorieInitial: indexCategorieInitial,
        rechargeAjout: rechargeAjout,
        rechargeModif: rechargeModif,
      ),
      titre: categorieInitial == null
          ? 'Ajout catégorie'
          : 'Modifier catégorie',
      menuSelection: 'Catégories',
    );
  }
}
