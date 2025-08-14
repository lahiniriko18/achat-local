import 'package:flutter/material.dart';
import 'dart:io';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';

class ImagePickerWidget extends StatelessWidget {
  final Future<void> Function() importerImage;
  final File? imageSelectione;
  final String? imageUrl;

  const ImagePickerWidget({
    super.key,
    required this.importerImage,
    this.imageSelectione,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    Widget preview;

    if (imageSelectione != null) {
      preview = Image.file(
        imageSelectione!,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      preview = Image.network(
        imageUrl!,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Text("Erreur de chargement image");
        },
      );
    } else {
      preview = Text("Aucune image sélectionnée");
    }
    return Column(
      children: [
        preview,
        const SizedBox(height: 8),
        SimpleBouton(
          texte: "Choisir une image",
          transparent: true,
          icone: Icon(Icons.image, color: Theme.of(context).primaryColor),
          action: importerImage,
        ),
      ],
    );
  }
}
