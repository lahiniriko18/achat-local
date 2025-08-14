import 'package:flutter/material.dart';
import 'package:premier_app/data/models/categorie.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/data/models/image.dart';
import 'package:premier_app/data/repositories/categorie_repos.dart';
import 'package:premier_app/data/repositories/image_repos.dart';
import 'package:premier_app/data/repositories/produit_repos.dart';
import 'package:premier_app/presentation/widgets/elements/input_widget.dart';
import 'package:premier_app/presentation/widgets/elements/image_picker_widget.dart';
import 'package:premier_app/presentation/widgets/elements/combobox_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FormulaireProduitWidget extends StatefulWidget {
  final Produit? produitInitial;
  final int? indexProduitInitial;
  final Function(Produit)? rechargeAjout;
  final Function(int, Produit)? rechargeModif;

  const FormulaireProduitWidget({
    super.key,
    this.produitInitial,
    this.indexProduitInitial,
    this.rechargeAjout,
    this.rechargeModif,
  });

  @override
  State<FormulaireProduitWidget> createState() =>
      FormulaireProduitWidgetState();
}

class FormulaireProduitWidgetState extends State<FormulaireProduitWidget> {
  final _formKey = GlobalKey<FormState>();
  File? imageSelectione;
  List<Categorie> categories = [];
  Categorie? categorieSelectione;
  String? imageUrlInitial;
  bool isLoading = false;

  late TextEditingController libelleController;
  late TextEditingController quantiteController;
  late TextEditingController prixController;
  late TextEditingController uniteController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    chargerChamps();
    chargeCategories();
    if (widget.produitInitial != null &&
        widget.produitInitial!.images.isNotEmpty) {
      setState(() {
        imageUrlInitial = widget.produitInitial!.images[0];
      });
    }
  }

  @override
  void dispose() {
    libelleController.dispose();
    quantiteController.dispose();
    prixController.dispose();
    uniteController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void chargerChamps() {
    final p = widget.produitInitial;
    libelleController = TextEditingController(text: p?.libelleProduit ?? '');
    quantiteController = TextEditingController(
      text: p?.quantite.toString() ?? '',
    );
    prixController = TextEditingController(
      text: p?.prixUnitaire.toString() ?? '',
    );
    uniteController = TextEditingController(text: p?.uniteMesure ?? '');
    descriptionController = TextEditingController(text: p?.description ?? '');
  }

  void chargeCategories() async {
    try {
      final cat = await CategorieRepos().tousCategories();
      setState(() {
        categories = cat;
        if (cat.isNotEmpty) {
          if (widget.produitInitial != null &&
              widget.produitInitial!.categorie != null) {
                categorieSelectione = categories.where((c) => c.numCategorie==widget.produitInitial!.categorie!.numCategorie).first;
          } else {
            categorieSelectione = cat.first;
          }
        }
      });
    } catch (e) {
      print("Erreur chargement catégorie : $e");
    }
  }

  void selectionnerCat(Categorie? cat) {
    setState(() {
      categorieSelectione = cat;
    });
  }

  void resetForm() {
    _formKey.currentState!.reset();
    libelleController.clear();
    quantiteController.clear();
    prixController.clear();
    uniteController.clear();
    descriptionController.clear();
  }

  Future<void> importerImage() async {
    final picker = ImagePicker();
    final fichierPick = await picker.pickImage(source: ImageSource.gallery);

    if (fichierPick != null) {
      setState(() {
        imageSelectione = File(fichierPick.path);
      });
    }
  }

  void envoyerFormulaire() async {
    if (_formKey.currentState!.validate()) {
      final donnee = {
        "libelleProduit": libelleController.text,
        "numCategorie": categorieSelectione?.numCategorie,
        "quantite": double.tryParse(quantiteController.text) ?? 0,
        "prixUnitaire": double.tryParse(prixController.text) ?? 0,
        "uniteMesure": uniteController.text,
        "description": descriptionController.text,
      };
      setState(() => isLoading = true);
      try {
        String message = '';
        if (widget.produitInitial == null) {
          Produit nouveauProduit = await ProduitRepos().ajouterProduit(donnee);
          if (imageSelectione != null) {
            final donneeImage = {
              "nomImage": imageSelectione,
              "numProduit": nouveauProduit.numProduit,
            };
            ImageProduit image = await ImageRepos().ajouterImage(donneeImage);
            nouveauProduit.images = [image.nomImage];
          }
          message = "Produit ajouté : ${nouveauProduit.libelleProduit}";
          widget.rechargeAjout!(nouveauProduit);
        } else {
          Produit nouveauProduit = await ProduitRepos().modifierProduit(
            donnee,
            widget.produitInitial!.numProduit,
          );
          if (imageSelectione != null) {
            if (imageUrlInitial != null) {
              final donneeImage = {
                "nomImage": imageSelectione,
                "numProduit": nouveauProduit.numProduit,
              };
              ImageProduit image = await ImageRepos().modifierImage(
                donneeImage,
              );
              nouveauProduit.images = [image.nomImage];
            } else {
              final donneeImage = {
                "nomImage": imageSelectione,
                "numProduit": nouveauProduit.numProduit,
              };
              ImageProduit image = await ImageRepos().ajouterImage(donneeImage);
              nouveauProduit.images = [image.nomImage];
            }
          }
          widget.rechargeModif!(widget.indexProduitInitial!, nouveauProduit);
          message = "Produit modifié : ${nouveauProduit.libelleProduit}";
        }
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        resetForm();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur : $e")));
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              widget.produitInitial == null
                  ? "Ajouter une nouvelle produit"
                  : "Modifier une produit",
            ),
          ),
          SizedBox(height: 20),
          InputWidget(
            nomInput: "Nom du produit",
            inputControlleur: libelleController,
            isOutline: true,
            validation: (value) =>
                value == null || value.isEmpty ? 'Obligatoire' : null,
          ),
          SizedBox(height: 16),
          InputWidget(
            nomInput: "Quantité",
            inputControlleur: quantiteController,
            type: TextInputType.number,
            isOutline: true,
            validation: (value) =>
                value == null || value.isEmpty ? 'Obligatoire' : null,
          ),
          SizedBox(height: 16),
          InputWidget(
            nomInput: "Prix unitaire",
            inputControlleur: prixController,
            type: TextInputType.number,
            isOutline: true,
            validation: (value) =>
                value == null || value.isEmpty ? 'Obligatoire' : null,
          ),
          SizedBox(height: 16),
          InputWidget(
            nomInput: "Unité de mesure",
            inputControlleur: uniteController,
            isOutline: true,
            validation: (value) =>
                value == null || value.isEmpty ? 'Obligatoire' : null,
          ),
          SizedBox(height: 16),
          InputWidget(
            nomInput: "Description",
            inputControlleur: descriptionController,
            isOutline: true,
            maxLigne: 3,
          ),
          SizedBox(height: 16),
          ComboboxCategorieWidget(
            categories: categories,
            selectionner: selectionnerCat,
            categorieSelectione: categorieSelectione,
          ),
          SizedBox(height: 16),
          Text(
            "Image de produit :",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ImagePickerWidget(
            importerImage: importerImage,
            imageSelectione: imageSelectione,
            imageUrl: imageUrlInitial,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLoading ? null : envoyerFormulaire,
            child: Text(
              widget.produitInitial == null
                  ? (isLoading ? "Ajout..." : "Ajouter")
                  : (isLoading ? "Modification..." : "Modifier"),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
