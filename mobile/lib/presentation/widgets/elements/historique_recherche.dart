import 'package:flutter/material.dart';
import 'package:premier_app/configuration/config.dart';
import 'package:premier_app/presentation/widgets/elements/confirmation_widget.dart';
import 'package:provider/provider.dart';

class HistoriqueRechercheWidget extends StatelessWidget {
  final Function(String) rechercheParHistorique;

  HistoriqueRechercheWidget({super.key, required this.rechercheParHistorique});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final config = Provider.of<Config>(context);
    final historiques = config.recherches;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                "Historiques",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: config.couleurTexte,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return ConfirmationWidget(
                        action: () {
                          return config.effacerRecherches();
                        },
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.delete_forever,
                  color: config.couleurTexte,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Wrap(
              spacing: 10,
              runSpacing: 15,
              children: historiques.map((valeur) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 0,
                    maxWidth: MediaQuery.of(context).size.width / 5,
                    minHeight: 30,
                    maxHeight: 30,
                  ),
                  child: ElevatedButton(
                    onPressed: () => rechercheParHistorique(valeur),
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 10),
                      ),
                      backgroundColor: WidgetStatePropertyAll(primaryColor),
                      elevation: WidgetStatePropertyAll(1),
                    ),
                    child: Text(
                      valeur,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
