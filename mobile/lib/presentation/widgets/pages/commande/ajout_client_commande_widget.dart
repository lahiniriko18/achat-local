import 'package:flutter/material.dart';
import 'package:premier_app/data/models/client.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/data/repositories/commande_repos.dart';
import 'package:premier_app/presentation/widgets/elements/combobox_widget.dart';
import 'package:premier_app/presentation/widgets/elements/input_widget.dart';
import 'package:premier_app/data/repositories/client_repos.dart';

class FormulaireClientCommandeWidget extends StatefulWidget {
  final List<Map<String, dynamic>> produitsCommandes;
  const FormulaireClientCommandeWidget({
    super.key,
    required this.produitsCommandes,
  });

  @override
  State<FormulaireClientCommandeWidget> createState() =>
      FormulaireClientCommandeWidgetState();
}

class FormulaireClientCommandeWidgetState
    extends State<FormulaireClientCommandeWidget> {
  final formClient = GlobalKey<FormState>();
  final formCommande = GlobalKey<FormState>();
  bool isLoadingClient = false;
  bool isLoadingCommande = false;
  List<Client> clients = [];
  Client? clientSelectione;

  final TextEditingController nomController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  TextEditingController referenceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    chargeClients();
  }

  @override
  void dispose() {
    nomController.dispose();
    contactController.dispose();
    adresseController.dispose();
    super.dispose();
  }

  void resetForm() {
    formClient.currentState!.reset();
    nomController.clear();
    contactController.clear();
    adresseController.clear();
  }

  void selectionnerClient(Client? client) {
    setState(() {
      clientSelectione = client;
    });
  }

  void chargeClients() async {
    try {
      final cs = await ClientRepos().tousClients();
      setState(() {
        clients = cs;
        if (cs.isNotEmpty) {
          clientSelectione = cs.first;
        }
      });
    } catch (e) {
      print("Erreur chargement des clients : $e");
    }
  }

  void envoyerFormulaireClient() async {
    if (formClient.currentState!.validate()) {
      final donnee = {
        "nom": nomController.text,
        "contact": "+261${contactController.text}",
        "adresse":adresseController.text
      };
      setState(() => isLoadingClient = true);
      try {
        String message = '';
        Client nouveauClient = await ClientRepos().ajouterClient(donnee);
        setState(() {
          clients.insert(0, nouveauClient);
          clientSelectione = nouveauClient;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        resetForm();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur : $e")));
      } finally {
        setState(() => isLoadingClient = false);
      }
    }
  }

  void envoyerFormulaireCommande() async {
    if (formCommande.currentState!.validate()) {
      setState(() => isLoadingCommande = true);
      try {
        Map<String, dynamic> donnees = {};
        List<Map<String, dynamic>> produitsCommandes = widget.produitsCommandes;
        donnees['numClient'] = clientSelectione?.numClient;
        donnees['reference'] = referenceController.text;
        donnees['produits'] = produitsCommandes;
        Commande nouveauCommande = await CommandeRepos().ajouterCommande(
          donnees,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Commande ajouté!')));
        resetForm();
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/commande',
          (route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur : $e")));
      } finally {
        setState(() => isLoadingCommande = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(height: 20),
        Center(child: Text("Séléctionner un client et saisir votre réference")),
        SizedBox(height: 20),
        Form(
          key: formClient,
          child: Column(
            children: [
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
                  if (!(val == null || val.isEmpty) && (val.length < 3)) {
                    return "L'adresse doit contenir au moins 3 caractères s'il n'est pas vide!";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isLoadingClient ? null : envoyerFormulaireClient,
          child: Text(
            isLoadingClient ? "Ajout..." : "Ajouter",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: primaryColor),
          ),
        ),
        const SizedBox(height: 20),
        ComboboxClientWidget(
          clients: clients,
          selectionner: selectionnerClient,
          clientSelectione: clientSelectione,
        ),
        SizedBox(height: 16),
        Form(
          key: formCommande,
          child: InputWidget(
            nomInput: "Réference",
            inputControlleur: referenceController,
            isOutline: true,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isLoadingCommande ? null : envoyerFormulaireCommande,
          child: Text(
            isLoadingCommande ? "Enregistrement..." : "Enregistrer",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: primaryColor),
          ),
        ),
      ],
    );
  }
}
