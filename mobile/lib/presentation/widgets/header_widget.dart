import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String titre;
  final bool afficheRecherche;
  final String menuSelection;
  final Function()? rechercher;

  const AppbarWidget({
    super.key,
    required this.titre,
    required this.afficheRecherche,
    required this.menuSelection,
    this.rechercher,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          );
        },
      ),
      title: Text(
        titre,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: const IconThemeData(color: Colors.white, size: 30),
      actions: [
        if (afficheRecherche)
          IconButton(onPressed: rechercher, icon: Icon(Icons.search)),
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () async {
            final RenderBox button = context.findRenderObject() as RenderBox;
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;

            final Offset position = button.localToGlobal(
              Offset.zero,
              ancestor: overlay,
            );
            final selected = await showMenu<String>(
              context: context,
              position: RelativeRect.fromLTRB(
                position.dx + button.size.width,
                position.dy + 70,
                0,
                0,
              ),
              items: [
                PopupMenuItem(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 10),
                      Text("Profile"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'parametre',
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 10),
                      Text("Paramètre"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'deconnexion',
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 10),
                      Text("Déconnexion"),
                    ],
                  ),
                ),
              ],
            );
            if (selected == 'profile') {
              Navigator.pushNamed(context, '/compte/profile');
            } else if (selected == 'parametre') {
              if (menuSelection != 'Paramètre') {
                Navigator.pushReplacementNamed(context, '/parametre');
              } else {
                Navigator.pop(context);
              }
            } else if (selected == 'deconnexion') {
              Navigator.pushReplacementNamed(context, '/connexion');
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
