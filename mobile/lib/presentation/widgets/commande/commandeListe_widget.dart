import 'package:flutter/material.dart';
import 'package:premier_app/data/models/commande.dart';
import 'package:premier_app/presentation/widgets/commande/commandeCard_widget.dart';
import 'package:premier_app/presentation/widgets/elements/chargement_widget.dart';

class CommandelisteWidget extends StatelessWidget {

  final Future<List<Commande>> commandes;

  CommandelisteWidget({
    super.key,
    required this.commandes
  });


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: commandes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Chargement();
        } else if (snapshot.hasError) {
          return Center(child: Text("Erreur : ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Aucun produit"));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
            itemBuilder: (context, index) {
              final commande = snapshot.data![index];
              return CommandeCard(commande: commande);
            },
          );
        }
      },
    );
  }
}