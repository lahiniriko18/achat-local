import 'package:flutter/material.dart';
import 'package:premier_app/data/models/client.dart';
import 'package:premier_app/presentation/widgets/elements/input_widget.dart';
import 'package:premier_app/data/repositories/client_repos.dart';

class FormulaireClientWidget extends StatefulWidget {
  final Client? clientInitial;
  final int? indexClientInitial;
  final Function(Client)? rechargeAjout;
  final Function(int, Client)? rechargeModif;

  const FormulaireClientWidget({
    super.key,
    this.clientInitial,
    this.indexClientInitial,
    this.rechargeAjout,
    this.rechargeModif,
  });

  @override
  State<FormulaireClientWidget> createState() => FormulaireClientWidgetState();
}

class FormulaireClientWidgetState extends State<FormulaireClientWidget> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late TextEditingController nomController;
  late TextEditingController contactController;
  late TextEditingController adresseController;

  @override
  void initState() {
    super.initState();
    chargerChamps();
  }

  @override
  void dispose() {
    nomController.dispose();
    contactController.dispose();
    adresseController.dispose();
    super.dispose();
  }

  void chargerChamps() {
    final c = widget.clientInitial;
    nomController = TextEditingController(text: c?.nom ?? '');
    contactController = TextEditingController(text: c?.contact ?? '');
    adresseController = TextEditingController(text: c?.adresse ?? '');
  }

  void resetForm() {
    _formKey.currentState!.reset();
    nomController.clear();
    contactController.clear();
    adresseController.clear();
  }

  void envoyerFormulaire() async {
    if (_formKey.currentState!.validate()) {
      final donnee = {
        "nom": nomController.text,
        "contact": "+261${contactController.text}",
        "adresse":adresseController.text
      };
      setState(() => isLoading = true);
      try {
        String message = '';
        if (widget.clientInitial == null) {
          Client nouveauClient = await ClientRepos().ajouterClient(donnee);
          message = "Client ajouté : ${nouveauClient.nom}";
          widget.rechargeAjout!(nouveauClient);
        } else {
          Client nouveauClient = await ClientRepos().modifierClient(
            donnee,
            widget.clientInitial!.numClient,
          );
          message = "Client modifié : ${nouveauClient.nom}";
          widget.rechargeModif!(widget.indexClientInitial!, nouveauClient);
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
    final primaryColor = Theme.of(context).primaryColor;
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              widget.clientInitial == null
                  ? "Ajouter une nouvelle client"
                  : "Modifier une client",
            ),
          ),
          SizedBox(height: 20),
          InputWidget(
            nomInput: "Nom du client",
            inputControlleur: nomController,
            isOutline: true,
            validation: (value) =>
                value == null || value.isEmpty ? 'Obligatoire' : null,
          ),
          SizedBox(height: 16),
          InputWidget(
            nomInput: "Contact",
            inputControlleur: contactController,
            isOutline: true,
            prefixe: "+261",
            validation: (val) {
              if (!(val == null || val.isEmpty) &&
                  (!RegExp(r'^\d{9}$').hasMatch(val.replaceAll(' ', '')))) {
                return 'Le numéro doit contenir exactement 9 chiffres';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          InputWidget(
            nomInput: "Adresse",
            inputControlleur: adresseController,
            isOutline: true,
            validation: (val) {
              if (!(val == null || val.isEmpty) &&
                  (val.length < 3)) {
                return "L'adresse doit contenir au moins 3 caractères s'il n'est pas vide!";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: isLoading ? null : envoyerFormulaire,
            icon: isLoading
                ? CircularProgressIndicator(strokeWidth: 2, color: primaryColor)
                : Icon(Icons.person_add, color: primaryColor),
            label: Text(
              widget.clientInitial == null
                  ? (isLoading ? "Ajout..." : "Ajouter")
                  : (isLoading ? "Modification..." : "Modifier"),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
