import 'package:flutter/material.dart';
import 'package:premier_app/data/models/categorie.dart';
import 'package:premier_app/presentation/widgets/pages/categorie/categorie_liste_widget.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';

class CategorieWidget extends StatelessWidget {
  final List<Categorie> categories;
  final Function(int) rechargeSuppression;
  final Function(int, Categorie) rechargeModif;
  final Function(Categorie) rechargeAjout;
  final bool isLoading;

  const CategorieWidget({
    super.key,
    required this.categories,
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
                '/categorie/ajout',
                arguments: {"rechargeAjout": rechargeAjout},
              );
            },
          ),
          Expanded(
            child: CategorieListeWidget(
              categories: categories,
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
