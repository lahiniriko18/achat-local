import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';

class SelectionProduitWidget extends StatefulWidget {
  final List<Produit>? produits;
  final Function(Map<int, bool>) selectionner;
  final Map<int, bool> selectionProduits;
  const SelectionProduitWidget({
    super.key,
    required this.produits,
    required this.selectionner,
    required this.selectionProduits,
  });

  @override
  State<SelectionProduitWidget> createState() => SelectionProduitPage();
}

class SelectionProduitPage extends State<SelectionProduitWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            Map<int, bool> selectionProduits = widget.selectionProduits;
            return StatefulBuilder(
              builder: (context, setStateDialog) {
                return AlertDialog(
                  title: Text("Sélectionner des produits"),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.produits!.length,
                      itemBuilder: (context, index) {
                        final produit = widget.produits![index];
                        return CheckboxListTile(
                          title: Text(produit.libelleProduit),
                          subtitle: Text("${produit.prixUnitaire} Ar"),
                          value: selectionProduits[produit.numProduit] ?? false,
                          onChanged: (bool? value) {
                            setStateDialog(() {
                              selectionProduits[produit.numProduit] =
                                  value ?? false;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        'Fermer',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text(
                        'Appliquer',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        widget.selectionner(selectionProduits);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Text("Sélectionner des produits"),
    );
  }
}
