import 'package:flutter/material.dart';

class ListageWidget extends StatelessWidget {

  final String titre;
  final String? valeur;

  ListageWidget ({
    super.key,
    required this.titre,
    this.valeur
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            titre,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Text(
          valeur ?? ""
        )
      ],
    );
  }
}