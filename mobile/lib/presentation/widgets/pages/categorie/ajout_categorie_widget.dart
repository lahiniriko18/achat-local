import 'package:flutter/material.dart';
import 'package:premier_app/data/models/categorie.dart';
import 'package:premier_app/data/repositories/categorie_repos.dart';
import 'package:premier_app/presentation/widgets/elements/input_widget.dart';
import 'package:premier_app/presentation/widgets/elements/image_picker_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FormulaireCategorieWidget extends StatefulWidget {
  final Categorie? categorieInitial;
  final int? indexCategorieInitial;
  final Function(Categorie)? rechargeAjout;
  final Function(int, Categorie)? rechargeModif;

  const FormulaireCategorieWidget({
    super.key,
    this.categorieInitial,
    this.indexCategorieInitial,
    this.rechargeAjout,
    this.rechargeModif,
  });

  @override
  State<FormulaireCategorieWidget> createState() =>
      FormulaireCategorieWidgetState();
}

class FormulaireCategorieWidgetState extends State<FormulaireCategorieWidget> {
  final _formKey = GlobalKey<FormState>();
  File? imageSelectione;
  String? imageUrlInitial;
  bool isLoading = false;

  late TextEditingController nomCategorieController;
  late TextEditingController descCategorieController;

  @override
  void initState() {
    super.initState();
    chargerChamps();
    if (widget.categorieInitial != null &&
        widget.categorieInitial!.imageCategorie != null) {
      setState(() {
        imageUrlInitial = widget.categorieInitial!.imageCategorie!;
      });
    }
  }

  @override
  void dispose() {
    nomCategorieController.dispose();
    descCategorieController.dispose();
    super.dispose();
  }

  void chargerChamps() {
    final c = widget.categorieInitial;
    nomCategorieController = TextEditingController(text: c?.nomCategorie ?? '');
    descCategorieController = TextEditingController(
      text: c?.descCategorie ?? '',
    );
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

  void resetForm() {
    _formKey.currentState!.reset();
    nomCategorieController.clear();
    descCategorieController.clear();
  }

  void envoyerFormulaire() async {
    if (_formKey.currentState!.validate()) {
      final donnee = {
        "nomCategorie": nomCategorieController.text,
        "imageCategorie": imageSelectione,
        "descCategorie": descCategorieController.text,
      };
      setState(() => isLoading = true);
      try {
        String message = '';
        if (widget.categorieInitial == null) {
          Categorie nouveauCategorie = await CategorieRepos().ajouterCategorie(
            donnee,
          );
          message = "Categorie ajouté : ${nouveauCategorie.nomCategorie}";
          widget.rechargeAjout!(nouveauCategorie);
        } else {
          Categorie nouveauCategorie = await CategorieRepos().modifierCategorie(
            donnee,
            widget.categorieInitial!.numCategorie,
          );
          message = "Categorie modifié : ${nouveauCategorie.nomCategorie}";
          widget.rechargeModif!(widget.indexCategorieInitial!, nouveauCategorie);
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
              widget.categorieInitial == null
                  ? "Ajouter une nouvelle catégorie"
                  : "Modifier une catégorie",
            ),
          ),
          SizedBox(height: 20),
          InputWidget(
            nomInput: "Nom du catégorie",
            inputControlleur: nomCategorieController,
            isOutline: true,
            validation: (value) =>
                value == null || value.isEmpty ? 'Obligatoire' : null,
          ),
          SizedBox(height: 16),
          InputWidget(
            nomInput: "Description",
            inputControlleur: descCategorieController,
            isOutline: true,
            maxLigne: 3,
          ),
          SizedBox(height: 16),
          Text(
            "Image du catégorie :",
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
              widget.categorieInitial == null
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
