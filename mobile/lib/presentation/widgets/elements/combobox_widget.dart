import 'package:flutter/material.dart';
import 'package:premier_app/data/models/categorie.dart';
import 'package:premier_app/data/models/classement.dart';
import 'package:premier_app/data/models/produit.dart';
import 'package:premier_app/data/models/client.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';

class ComboboxCategorieWidget extends StatelessWidget {
  final List<Categorie> categories;
  final Categorie? categorieSelectione;
  final Function(Categorie?) selectionner;
  const ComboboxCategorieWidget({
    super.key,
    required this.categories,
    this.categorieSelectione,
    required this.selectionner,
  });

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<Config>(context);
    Color couleurTexte = config.couleurTexte;
    return DropdownButtonFormField<Categorie>(
      value: categorieSelectione,
      decoration: InputDecoration(
        label: Text(
          'Catégorie',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: couleurTexte),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      items: categories.map((Categorie c) {
        return DropdownMenuItem<Categorie>(
          value: c,
          child: Text(c.nomCategorie),
        );
      }).toList(),
      onChanged: (Categorie? nouveauCat) {
        selectionner(nouveauCat);
      },
      validator: (value) => value == null ? 'Catégorie requise' : null,
    );
  }
}

class ComboboxClassementWidget extends StatelessWidget {
  final List<Classement> classements;
  final Classement? classementSelectione;
  final Function(Classement?) selectionner;
  const ComboboxClassementWidget({
    super.key,
    required this.classements,
    this.classementSelectione,
    required this.selectionner,
  });

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<Config>(context);
    Color couleurTexte = config.couleurTexte;
    return DropdownButtonFormField<Classement>(
      value: classementSelectione,
      decoration: InputDecoration(
        label: Text(
          'Classement',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: couleurTexte),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      items: classements.map((Classement c) {
        return DropdownMenuItem<Classement>(
          value: c,
          child: Text(c.nomClassement),
        );
      }).toList(),
      onChanged: (Classement? nouveauCat) {
        selectionner(nouveauCat);
      },
    );
  }
}

class ComboboxClientWidget extends StatelessWidget {
  final List<Client> clients;
  final Client? clientSelectione;
  final Function(Client?) selectionner;
  const ComboboxClientWidget({
    super.key,
    required this.clients,
    this.clientSelectione,
    required this.selectionner,
  });

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<Config>(context);
    Color couleurTexte = config.couleurTexte;
    return DropdownButtonFormField<Client>(
      value: clientSelectione,
      decoration: InputDecoration(
        label: Text(
          'Client',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: couleurTexte),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      items: clients.map((Client c) {
        return DropdownMenuItem<Client>(
          value: c,
          child: Text(c.nom),
        );
      }).toList(),
      onChanged: (Client? nouveauClient) {
        selectionner(nouveauClient);
      },
    );
  }
}

class ComboboxProduitWidget extends StatelessWidget {
  final List<Produit> produits;
  final Produit? produitSelectione;
  final Function(Produit?) selectionner;
  const ComboboxProduitWidget({
    super.key,
    required this.produits,
    this.produitSelectione,
    required this.selectionner,
  });

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<Config>(context);
    Color couleurTexte = config.couleurTexte;
    return DropdownButtonFormField<Produit>(
      value: produitSelectione,
      decoration: InputDecoration(
        label: Text(
          'Produit',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: couleurTexte),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      items: produits.map((Produit p) {
        return DropdownMenuItem<Produit>(
          value: p,
          child: Text("${p.libelleProduit}(${p.prixUnitaire} Ar)"),
        );
      }).toList(),
      onChanged: (Produit? nouveauProduit) {
        selectionner(nouveauProduit);
      },
    );
  }
}