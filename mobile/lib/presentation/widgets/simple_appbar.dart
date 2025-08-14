import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titre;
  final String? menuSelection;

  const SimpleAppBar({super.key, required this.titre, this.menuSelection});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.chevron_left, size: 40, color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(titre, style: TextStyle(color: Colors.white, fontSize: 25)),
      iconTheme: const IconThemeData(color: Colors.white, size: 30),
      actions: [
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
              if (menuSelection != null && menuSelection! != 'Paramètre') {
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
