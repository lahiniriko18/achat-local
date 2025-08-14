import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/data/models/categorie.dart';
import 'package:premier_app/presentation/widgets/elements/chargement_widget.dart';
import 'package:premier_app/presentation/widgets/elements/listage_widget.dart';

class DetailsCategorieWidget extends StatelessWidget {
  final Map<String, dynamic> donnees;
  final bool isLoading;
  const DetailsCategorieWidget({
    super.key,
    required this.donnees,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final List<Produit> produits = donnees['produits'];
    final Categorie categorie = donnees['categorie'];
    Widget preview = Center(child: Text("Aucun produit"));
    if (produits.isNotEmpty) {
      preview = Column(
        children: List.generate(produits.length * 2 - 1, (index) {
          if (index.isEven) {
            Produit p = produits[index ~/ 2];
            return Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipOval(
                      child: (p.images.isNotEmpty)
                          ? Image.network(p.images[0], fit: BoxFit.cover)
                          : Image.asset(
                              'assets/images/default-produit.jpeg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListageWidget(
                              titre: "Nom :",
                              valeur: p.libelleProduit,
                            ),
                            ListageWidget(
                              titre: "Quantité :",
                              valeur: "${p.quantite} ${p.uniteMesure}",
                            ),
                            ListageWidget(
                              titre: "Prix unitaire :",
                              valeur: "${p.prixUnitaire} Ar",
                            ),
                            ListageWidget(
                              titre: "Description :",
                              valeur: p.description,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Divider();
          }
        }),
      );
    }
    return (isLoading)
        ? Chargement()
        : SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: (categorie.imageCategorie != null)
                                ? Image.network(
                                    categorie.imageCategorie!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/default-produit.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListageWidget(
                                  titre: "Nom :",
                                  valeur: categorie.nomCategorie,
                                ),
                                ListageWidget(
                                  titre: "Nombre de produits :",
                                  valeur:
                                      "${produits.length} produit${produits.length > 1 ? 's' : ''}",
                                ),
                                ListageWidget(
                                  titre: "Déscription :",
                                  valeur: categorie.descCategorie,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Produits dans le catégorie ${categorie.nomCategorie}",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(),
                        preview,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
