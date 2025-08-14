import 'package:flutter/material.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/presentation/widgets/pages/produit/ajout_produit_widget.dart';
import 'package:premier_app/presentation/layouts/detail_layout.dart';

class FormulaireProduit extends StatelessWidget {
  final Produit? produitInitial;
  final int? indexProduitInitial;
  final Function(Produit)? rechargeAjout;
  final Function(int, Produit)? rechargeModif;

  const FormulaireProduit({
    super.key,
    this.produitInitial,
    this.indexProduitInitial,
    this.rechargeAjout,
    this.rechargeModif,
  });

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      body: FormulaireProduitWidget(
        produitInitial: produitInitial,
        indexProduitInitial: indexProduitInitial,
        rechargeAjout: rechargeAjout,
        rechargeModif: rechargeModif,
      ),
      titre: produitInitial == null ? 'Ajout produit' : 'Modifier produit',
      menuSelection: 'Produits',
    );
  }
}
