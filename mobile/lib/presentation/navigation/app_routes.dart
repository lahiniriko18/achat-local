import 'package:flutter/material.dart';
import 'package:premier_app/presentation/screens/historiques/historique.dart';
import 'package:premier_app/presentation/screens/pages/accueil.dart';
import 'package:premier_app/presentation/screens/historiques/recherche.dart';
import 'package:premier_app/presentation/screens/compte/profile.dart';
import 'package:premier_app/presentation/screens/compte/modifier_mdp.dart';
import 'package:premier_app/presentation/screens/compte/connexion.dart';
import 'package:premier_app/presentation/screens/compte/inscription.dart';
import 'package:premier_app/presentation/screens/historiques/details.dart';
import 'package:premier_app/presentation/screens/pages/categorie/ajout_categorie.dart';
import 'package:premier_app/presentation/screens/pages/categorie/categorie_details.dart';
import 'package:premier_app/presentation/screens/pages/categorie/recherche_categorie.dart';
import 'package:premier_app/presentation/screens/pages/client/ajout_client.dart';
import 'package:premier_app/presentation/screens/pages/client/client.dart';
import 'package:premier_app/presentation/screens/pages/client/recherche_client.dart';
import 'package:premier_app/presentation/screens/pages/commande/ajout_client_commande.dart';
import 'package:premier_app/presentation/screens/pages/commande/ajout_commande.dart';
import 'package:premier_app/presentation/screens/pages/commande/recherche_commande.dart';
import 'package:premier_app/presentation/screens/pages/details_commande.dart';
import 'package:premier_app/presentation/screens/pages/parametre.dart';
import 'package:premier_app/presentation/screens/pages/produit/produit.dart';
import 'package:premier_app/presentation/screens/pages/produit/ajout_produit.dart';
import 'package:premier_app/presentation/screens/pages/categorie/categorie.dart';
import 'package:premier_app/presentation/screens/pages/commande/commande.dart';
import 'package:premier_app/presentation/screens/pages/produit/produit_details.dart';
import 'package:premier_app/presentation/screens/pages/produit/recherche_produit.dart';
import 'package:premier_app/presentation/screens/pages/scan/scan.dart';

class AppRoutes {
  static final routes = {
    '/': (context) => Accueil(),
    '/scan': (context) => Scan(),
    '/historique': (context) => Historique(),
    '/parametre': (context) => Parametre(),
    '/produit': (context) => ProduitPage(),
    '/produit/ajout': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return FormulaireProduit(rechargeAjout: args['rechargeAjout']);
    },
    '/produit/modifier': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return FormulaireProduit(
        produitInitial: args['produitInitial'],
        indexProduitInitial: args['indexProduitInitial'],
        rechargeModif: args['rechargeModif'],
      );
    },
    '/produit/details': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return UneProduitDetails(produit: args['produit']);
    },
    '/produit/recherche': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return RechercheProduit(
        produits: args['produits'],
        rechargeSuppression: args['rechargeSuppression'],
        rechargeModif: args['rechargeModif'],
      );
    },
    '/client': (context) => ClientPage(),
    '/client/ajout': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return FormulaireClient(rechargeAjout: args['rechargeAjout']);
    },
    '/client/modifier': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return FormulaireClient(
        clientInitial: args['clientInitial'],
        indexClientInitial: args['indexClientInitial'],
        rechargeModif: args['rechargeModif'],
      );
    },
    '/client/recherche': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return RechercheClient(
        clients: args['clients'],
        rechargeSuppression: args['rechargeSuppression'],
        rechargeModif: args['rechargeModif'],
      );
    },
    '/categorie': (context) => CategoriePage(),
    '/categorie/ajout': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return FormulaireCategorie(rechargeAjout: args['rechargeAjout']);
    },
    '/categorie/modifier': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return FormulaireCategorie(
        categorieInitial: args['categorieInitial'],
        indexCategorieInitial: args['indexCategorieInitial'],
        rechargeModif: args['rechargeModif'],
      );
    },
    '/categorie/recherche': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return RechercheCategorie(
        categories: args['categories'],
        rechargeSuppression: args['rechargeSuppression'],
        rechargeModif: args['rechargeModif'],
      );
    },
    '/categorie/details': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return CategorieDetails(categorie: args['categorie']);
    },
    '/commande': (context) => CommandePage(),
    '/commande/client': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return FormulaireClientCommade(
        produitsCommandes: args['produitsCommandes'],
      );
    },
    '/commande/ajout': (context) => AjoutCommande(),
    '/commande/recherche': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return RechercheCommande(
        commandes: args['commandes'],
        rechargeSuppression: args['rechargeSuppression'],
      );
    },
    '/recherche': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return Recherche(listes: args['listes'], rechercher: args['rechercher']);
    },
    '/compte/profile': (context) => Profile(),
    '/compte/mdp': (context) => Modifiermdp(),
    '/connexion': (context) => Connexion(),
    '/inscription': (context) => Inscription(),
    '/details': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return Details(commande: args['commande']);
    },
    '/details-commande': (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return DetailsCommande(
        donnees: args['donnees'],
        viderPanier: args['viderPanier'],
        suivantCommande: args['suivantCommande'],
      );
    },
  };
}
