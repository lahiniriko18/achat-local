import 'package:flutter/material.dart';

class ConfirmationWidget extends StatelessWidget {
  final String? titre;
  final String? contenu;
  final Function() action;
  ConfirmationWidget({super.key, this.titre, this.contenu, required this.action});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titre ?? "Confirmation"),
      content: Text(contenu ?? "Etes-vous sûre ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Annuler"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            action();
          },
          child: const Text("Supprimer"),
        ),
      ],
    );
  }
}
