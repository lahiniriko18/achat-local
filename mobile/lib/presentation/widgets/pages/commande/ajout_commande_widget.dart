import 'package:flutter/material.dart';
import 'package:premier_app/core/utils/commande_utils.dart';
import 'package:premier_app/core/utils/produit_utils.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/data/repositories/produit_repos.dart';
import 'package:premier_app/presentation/widgets/elements/combobox_widget.dart';
import 'package:premier_app/presentation/widgets/elements/dialog_widget.dart';
import 'package:premier_app/presentation/widgets/elements/input_widget.dart';
import 'package:premier_app/presentation/widgets/elements/panier_selectionne_widget.dart';

class FormulaireCommandeWidget extends StatefulWidget {
  final Commande? commandeInitial;
  final Function(Commande commande) onSubmit;

  const FormulaireCommandeWidget({
    super.key,
    this.commandeInitial,
    required this.onSubmit,
  });

  @override
  State<FormulaireCommandeWidget> createState() =>
      FormulaireCommandeWidgetState();
}

class FormulaireCommandeWidgetState extends State<FormulaireCommandeWidget> {
  final formProduit = GlobalKey<FormState>();
  List<Map<String, dynamic>> donnees = [];

  List<Produit> produits = [];
  Produit? produitSelectionne;
  List<Map<String, dynamic>> produitsCommandes = [];

  TextEditingController quantiteCommandeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    chargeProduits();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void chargeProduits() async {
    try {
      final p = await ProduitRepos().tousProduits();
      setState(() {
        produits = p;
        if (p.isNotEmpty) {
          produitSelectionne = p.first;
        }
      });
    } catch (e) {
      print("Erreur chargement des produits : $e");
    }
  }

  void envoyerFormulaireProduit(BuildContext context) {
    if (formProduit.currentState!.validate() && produitSelectionne != null) {
      final Map<String, dynamic> d = {
        "produit": produitSelectionne!,
        "quantiteCommande":
            double.tryParse(quantiteCommandeController.text) ?? 1,
      };
      int index = ProduitUtils.existePanier(donnees, produitSelectionne!);
      double q = d['quantiteCommande'];
      if (index != -1) {
        q += donnees[index]['quantiteCommande'];
      }
      if (produitSelectionne!.quantite < q) {
        showDialog(
          context: context,
          builder: (_) => MessageDialog(
            titre: "Vérification",
            message: "Quantité du stock insuffisant",
          ),
        );
      } else {
        setState(() {
          if (index != -1) {
            donnees[index]['quantiteCommande'] += d['quantiteCommande'];
          } else {
            donnees.insert(0, d);
          }
        });
      }
    }
  }

  void supprimer(Produit p) {
    int index = ProduitUtils.existePanier(donnees, p);
    if (index != -1) {
      setState(() {
        donnees.removeAt(index);
      });
    }
  }

  void viderPanier() {
    setState(() {
      donnees.clear();
    });
  }

  void selectionnerProduit(Produit? produit) {
    setState(() {
      produitSelectionne = produit;
    });
  }

  void chargeDonneCommande() {
    for (Map<String, dynamic> d in donnees) {
      setState(() {
        produitsCommandes.add({
          "numProduit": d['produit'].numProduit,
          "quantiteCommande": d['quantiteCommande'],
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                widget.commandeInitial == null
                    ? "Séléctionner votre produit"
                    : "Modifier votre produit",
              ),
            ),
            SizedBox(height: 16),
            ComboboxProduitWidget(
              produits: produits,
              selectionner: selectionnerProduit,
            ),
            SizedBox(height: 16),
            Form(
              key: formProduit,
              child: InputWidget(
                nomInput: "Quantité commandé",
                inputControlleur: quantiteCommandeController,
                type: TextInputType.number,
                isOutline: true,
                valeur: "1",
                validation: (value) =>
                    value == null || value.isEmpty ? 'Obligatoire' : null,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => envoyerFormulaireProduit(context),
              child: Text(
                "Ajouter à mon panier",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: primaryColor),
              ),
            ),
            SizedBox(height: 8),
            PanierSelectionneWidget(
              donnees: donnees,
              supprimer: supprimer,
              viderPanier: viderPanier,
              suivantCommande: () => CommandeUtils.suivantCommande(
                context,
                chargeDonneCommande,
                produitsCommandes,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => CommandeUtils.suivantCommande(
                context,
                chargeDonneCommande,
                produitsCommandes,
              ),
              child: Text(
                "Suivant",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              viderPanier();
              Navigator.pushReplacementNamed(context, '/scan');
            },
            child: Icon(Icons.qr_code_scanner, size: 30),
            style: ElevatedButton.styleFrom(
              elevation: 4,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              foregroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
