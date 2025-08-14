import 'package:flutter/material.dart';
import 'package:premier_app/core/utils/commande_utils.dart';
import 'package:premier_app/core/utils/produit_utils.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/data/repositories/commande_repos.dart';
import 'package:premier_app/presentation/widgets/elements/listage_widget.dart';

class AccueilWidget extends StatefulWidget {
  const AccueilWidget({super.key});

  @override
  State<AccueilWidget> createState() => AccueilPage();
}

class AccueilPage extends State<AccueilWidget> {
  Commande? dernierCommande;

  @override
  void initState() {
    super.initState();
    chargeProduit();
  }

  void chargeProduit() async {
    try {
      Commande c = await CommandeRepos().dernierCommande();
      setState(() {
        dernierCommande = c;
      });
    } catch (e) {
      print("Erreur : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget preview = Center(child: Text("Aucun commande effectué"));
    if (dernierCommande != null) {
      int indexProduit = ProduitUtils.produitAyantImage(
        ProduitUtils.tousProduitsCommandes(dernierCommande!.produits),
      );
      Produit? p = (indexProduit != -1)
          ? dernierCommande!.produits[indexProduit]['produit']
          : null;
      List<Produit> produits = ProduitUtils.tousProduitsCommandes(
        dernierCommande!.produits,
      );
      preview = Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipOval(
                child: (p != null)
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
                        titre: "Client :",
                        valeur: dernierCommande!.client.nom,
                      ),
                      ListageWidget(
                        titre: "Date et heure :",
                        valeur: dernierCommande!.dateCommande
                            .toString()
                            .split(".")
                            .first,
                      ),
                      ListageWidget(
                        titre: "Produits :",
                        valeur: produits
                            .map((p) => p.libelleProduit)
                            .join(", "),
                      ),
                      ListageWidget(
                        titre: "Réference :",
                        valeur: "${CommandeUtils.montantPayer(dernierCommande!.produits)} Ar",
                      ),
                      ListageWidget(
                        titre: "Réference :",
                        valeur: dernierCommande!.reference,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                '/produit',
                              ),
                              child: Card(
                                elevation: 2,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.inventory_2,
                                        color: Colors.green,
                                        size: 40,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Produit",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                '/client',
                              ),
                              child: Card(
                                elevation: 2,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.people,
                                        color: Colors.blue,
                                        size: 40,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Client",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                '/commande',
                              ),
                              child: Card(
                                elevation: 2,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shopping_cart,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Commande",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.pushReplacementNamed(
                              context,
                              '/categorie',
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                elevation: 2,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.category,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Catégorie",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Dernière commande effectué",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(),
                      Expanded(child: preview),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
