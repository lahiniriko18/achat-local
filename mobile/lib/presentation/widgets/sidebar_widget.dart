import 'package:flutter/material.dart';
import 'package:premier_app/presentation/widgets/elements/menuitem_widget.dart';

class SidebarWidget extends StatelessWidget {
  final String menuSelection;
  const SidebarWidget({super.key, required this.menuSelection});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: kToolbarHeight + 24,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                "Menu",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
          MenuItemWidget(
            icone: Icon(Icons.home),
            titre: 'Accueil',
            menuSelection: menuSelection,
            action: () {
              if (menuSelection != 'Accueil') {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          MenuItemWidget(
            icone: Icon(Icons.add_a_photo),
            titre: 'Scan',
            menuSelection: menuSelection,
            action: () {
              if (menuSelection != 'Scan') {
                Navigator.pushReplacementNamed(context, '/scan');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          MenuItemWidget(
            icone: Icon(Icons.inventory_2),
            titre: 'Produits',
            menuSelection: menuSelection,
            action: () {
              if (menuSelection != 'Produits') {
                Navigator.pushReplacementNamed(context, '/produit');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          MenuItemWidget(
            icone: Icon(Icons.people),
            titre: 'Clients',
            menuSelection: menuSelection,
            action: () {
              if (menuSelection != 'Clients') {
                Navigator.pushReplacementNamed(context, '/client');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          MenuItemWidget(
            icone: Icon(Icons.shopping_cart),
            titre: 'Commandes',
            menuSelection: menuSelection,
            action: () {
              if (menuSelection != 'Commandes') {
                Navigator.pushReplacementNamed(context, '/commande');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          MenuItemWidget(
            icone: Icon(Icons.category),
            titre: 'Catégories',
            menuSelection: menuSelection,
            action: () {
              if (menuSelection != 'Catégories') {
                Navigator.pushReplacementNamed(context, '/categorie');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          MenuItemWidget(
            icone: Icon(Icons.history),
            titre: 'Historique',
            menuSelection: menuSelection,
            action: () {
              if (menuSelection != 'Historique') {
                Navigator.pushReplacementNamed(context, '/historique');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          MenuItemWidget(
            icone: Icon(Icons.settings),
            titre: 'Paramètre',
            menuSelection: menuSelection,
            action: () {
              if (menuSelection != 'Paramètre') {
                Navigator.pushReplacementNamed(context, '/parametre');
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
