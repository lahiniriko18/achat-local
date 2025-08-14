import 'package:flutter/material.dart';

class Bouton extends StatelessWidget {
  final String texte;
  final Size taille;
  final Function()? action;

  const Bouton({
    super.key,
    required this.texte,
    required this.taille,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).primaryColor,
        ),
        minimumSize: MaterialStateProperty.all(taille),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        shadowColor: MaterialStateProperty.all(Colors.black),
        elevation: MaterialStateProperty.all(1),
      ),
      child: Text(
        texte,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SimpleBouton extends StatelessWidget {
  final String texte;
  final Icon? icone;
  final bool? transparent;
  final Function()? action;

  const SimpleBouton({
    super.key,
    required this.texte,
    this.icone,
    this.transparent,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final isTransparent = transparent != null && transparent!;
    return ElevatedButton(
      onPressed: action,
      style: (!isTransparent)
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).primaryColor,
              ),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icone != null) ...[icone!, const SizedBox(width: 8)],
          Text(
            texte,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isTransparent
                  ? Theme.of(context).primaryColor
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
