import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:premier_app/core/utils/commande_utils.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/core/utils/produit_utils.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';
import 'package:premier_app/presentation/layouts/scan_layout.dart';
import 'package:premier_app/data/repositories/produit_repos.dart';
import 'package:premier_app/presentation/widgets/elements/dialog_widget.dart';
import 'package:premier_app/presentation/widgets/elements/panier_selectionne_widget.dart';

class ScanWidget extends StatefulWidget {
  const ScanWidget({super.key});

  ScanPage createState() => ScanPage();
}

class ScanPage extends State<ScanWidget> {
  String? codeScan;
  String? ancienCode;
  Future<Produit>? futureProduit;
  Produit? produit;
  List<Map<String, dynamic>> donnees = [];
  List<Map<String, dynamic>> produitsCommandes = [];

  @override
  void initState() {
    super.initState();
  }

  void setFutureProduit(String numProduit) {
    setState(() {
      futureProduit = ProduitRepos().uneProduit(numProduit);
    });
  }

  void setProduit(Produit p) {
    setState(() {
      produit = p;
    });
  }

  void supprimer(Produit p) {
    int index = ProduitUtils.existePanier(donnees, p);
    if (index != -1) {
      setState(() {
        donnees.removeAt(index);
      });
    }
  }

  void ajoutProduit(BuildContext context) {
    final Map<String, dynamic> d = {
      "produit": produit!,
      "quantiteCommande": 1.toDouble(),
    };
    int index = ProduitUtils.existePanier(donnees, produit!);
    double q = d['quantiteCommande'];
    if (index != -1) {
      q += donnees[index]['quantiteCommande'];
    }
    if (produit!.quantite < q) {
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
      annuler();
    }
  }

  void annuler() {
    setState(() {
      codeScan = null;
      produit = null;
      ancienCode = null;
    });
  }

  void viderPanier() {
    setState(() {
      donnees.clear();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(5),
                    child: MobileScanner(
                      onDetect: (barcodeCapture) {
                        final barcode = barcodeCapture.barcodes.first;
                        final String? code = barcode.rawValue;

                        if (code != null && code != ancienCode) {
                          setState(() {
                            ancienCode = codeScan;
                            codeScan = code;
                            setFutureProduit(codeScan!);
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: codeScan != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            ScanLayout(
                              produit: futureProduit!,
                              setProduit: setProduit,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SimpleBouton(texte: "Annuler", action: annuler),
                                SimpleBouton(
                                  texte: "Ajouter à mon panier",
                                  action: () => ajoutProduit(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Text("Scan en cours...", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: PanierSelectionneWidget(
                donnees: donnees,
                supprimer: supprimer,
                viderPanier: viderPanier,
                suivantCommande: () => CommandeUtils.suivantCommande(context, chargeDonneCommande, produitsCommandes),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => CommandeUtils.suivantCommande(context, chargeDonneCommande, produitsCommandes),
          child: Text(
            "Suivant",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
