import 'package:flutter/material.dart';
import 'package:premier_app/configuration/config.dart';
import 'package:premier_app/data/models/categorie.dart';
import 'package:premier_app/presentation/widgets/elements/historique_recherche.dart';
import 'package:premier_app/presentation/widgets/pages/categorie/categorie_liste_widget.dart';
import 'package:provider/provider.dart';

class RechercheCategorie extends StatefulWidget {
  final List<Categorie> categories;
  final Function(int) rechargeSuppression;
  final Function(int, Categorie) rechargeModif;

  const RechercheCategorie({
    super.key,
    required this.categories,
    required this.rechargeSuppression,
    required this.rechargeModif,
  });

  @override
  State<RechercheCategorie> createState() => RechercheCategorieState();
}

class RechercheCategorieState extends State<RechercheCategorie> {
  List<Categorie> categorieFiltres = [];
  bool afficheEffacheChamp = false;
  TextEditingController valeurControlleur = TextEditingController();

  @override
  void initState() {
    super.initState();
    categorieFiltres = widget.categories;
    valeurControlleur.addListener(() {
      print(valeurControlleur.text);
    },);
  }

  void filtrage(String valeur) {
    valeur = valeur.toLowerCase();
    setState(() {
      categorieFiltres = widget.categories.where((p) {
        return p.toSearchableString().contains(valeur);
      }).toList();
    });
  }

  void rechercheParHistorique(String valeur) {
    setState(() {
      valeurControlleur = TextEditingController(text: valeur);
      filtrage(valeur);
      afficheEffacheChamp = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<Config>(context);
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 35),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 50,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          size: 40,
                          color: (config.isDark) ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: TextFormField(
                          controller: valeurControlleur,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: primaryColor,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white54,
                            ),
                            suffixIcon: (afficheEffacheChamp)
                                ? IconButton(
                                    onPressed: () {
                                      valeurControlleur.clear();
                                      setState(() {
                                        afficheEffacheChamp = false;
                                      });
                                      filtrage(valeurControlleur.text);
                                    },
                                    icon: Icon(Icons.clear, color: Colors.white54,),
                                  )
                                : null,
                            hint: Text(
                              "Rechercher",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white24),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: (config.isDark) ? Colors.black54 : Colors.white54,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: (config.isDark) ? Colors.black54 : Colors.white54,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: (config.isDark) ? Colors.black54 : Colors.white54,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            floatingLabelStyle: TextStyle(color: Colors.white),
                          ),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                          cursorColor: Colors.white,
                          onChanged:(value) {
                            setState(() {
                              afficheEffacheChamp = value.isNotEmpty;
                            });
                            filtrage(value);
                          },
                          onFieldSubmitted: (value) {
                            config.ajouterRecherche(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            child: (config.recherches.isNotEmpty)
                ? HistoriqueRechercheWidget(rechercheParHistorique: rechercheParHistorique,)
                : null,
          ),
          SizedBox(height: 10),
          Expanded(
            child: CategorieListeWidget(
              categories: categorieFiltres,
              rechargeSuppression: widget.rechargeSuppression,
              rechargeModif: widget.rechargeModif,
              isLoading: false,
            ),
          ),
        ],
      ),
    );
  }
}
