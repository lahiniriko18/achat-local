import 'package:flutter/material.dart';

class ChargementDialog extends StatelessWidget {
  final String message;
  ChargementDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(
            color: Colors.blue,
          ),
          SizedBox(width: 20),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class MessageDialog extends StatelessWidget {
  final String titre;
  final String message;
  final String? texteBouton;
  MessageDialog({super.key, required this.titre, required this.message, this.texteBouton});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titre),
      content: Text(message),
      actions: [
        TextButton(
          child: Text(texteBouton ?? "OK"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}