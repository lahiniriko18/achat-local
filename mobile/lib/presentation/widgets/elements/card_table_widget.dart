import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';

class CardTableWidget extends StatelessWidget {
  final String? image;
  final String titre;
  final int index;
  final String? sousTitre;
  final Function()? details;
  final Function(BuildContext, int) supprimer;
  final Function? modification;
  final PopupMenuItem<String>? pdfMenu;
  const CardTableWidget({
    super.key,
    this.image,
    required this.titre,
    required this.index,
    this.sousTitre,
    this.details,
    required this.supprimer,
    this.modification,
    this.pdfMenu
  });
  void confirmerSuppression(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirmation"),
        content: Text("Etes-vous sûre ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              supprimer(context, index);
            },
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<Config>(context);
    Color couleurTexte = config.couleurTexte;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: details,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        title: Text(titre, style: Theme.of(context).textTheme.bodyMedium),
        subtitle: (sousTitre != null)
            ? Text(
                sousTitre!,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: couleurTexte),
              )
            : null,
        leading: (image != null)
            ? ClipOval(
                child: (image!.isNotEmpty)
                    ? Image.network(
                        image!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/default-produit.jpeg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
              )
            : null,
        trailing: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert),
          onSelected: (String value) {
            if (value == 'modifier') {
              (modification != null) ? modification!() : null;
            } else if (value == 'details') {
              (details != null) ? details!() : null;
            } else if (value == 'supprimer') {
              confirmerSuppression(context, index);
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(value: 'details', child: Text('Détails')),
            PopupMenuItem(value: 'modifier', child: Text('Modifier')),
            PopupMenuItem(value: 'supprimer', child: Text('Supprimer')),
          ],
        ),
      ),
    );
  }
}
