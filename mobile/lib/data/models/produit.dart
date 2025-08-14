import 'package:premier_app/core/utils/produit_utils.dart';
import 'package:premier_app/data/models/categorie.dart';

class Produit {
  int numProduit;
  Categorie? categorie;
  String libelleProduit;
  double quantite;
  double prixUnitaire;
  String uniteMesure;
  String description;
  String qrCode;
  List<String> images;

  Produit({
    required this.numProduit,
    required this.categorie,
    required this.libelleProduit,
    required this.quantite,
    required this.prixUnitaire,
    required this.uniteMesure,
    required this.description,
    required this.qrCode,
    required this.images,
  });

  factory Produit.fromJson(Map<String, dynamic> produit) {
    return Produit(
      numProduit: produit['numProduit'],
      categorie: Categorie.fromJson(produit['categorie']),
      libelleProduit: produit['libelleProduit'],
      quantite: produit['quantite'],
      prixUnitaire: produit['prixUnitaire'],
      uniteMesure: produit['uniteMesure'],
      description: produit['description'],
      qrCode: produit['qrCode'],
      images: ProduitUtils.dynamicToString(produit['images']),
    );
  }
  String toSearchableString() {
    return '''
      $libelleProduit
      $description
      $uniteMesure
      ${prixUnitaire.toString()}
      ${quantite.toString()}
    '''
        .toLowerCase();
  }
}
