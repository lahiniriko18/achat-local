import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';
import 'package:premier_app/core/utils/app_utils.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';

class ParametreWidget extends StatefulWidget {
  final Color themeCouleur;
  const ParametreWidget({
    super.key,
    required this.themeCouleur
  });

  @override
  State<ParametreWidget> createState() => ParametrePage();
}

class ParametrePage extends State<ParametreWidget> {
  late Color themeCouleur;
  Couleur couleurInstance = Couleur();

  void sauvegarder() {
    print("Mety");
  }

  @override
  void initState() {
    super.initState();
    themeCouleur=widget.themeCouleur;
  }

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<Config>(context);
    final isDark = config.isDark;
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 3,),
          ListTile(
            title: Text(
              "Paramètre du compte",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Icon(Icons.chevron_right),
            splashColor: couleurInstance.hexaToCouleur(config.theme).withOpacity(0.1),
            onTap: () {
              Navigator.pushNamed(context, '/compte/profile');
            },
          ),
          ListTile(
            title: Text(
              "Mot de passe et sécurité",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Icon(Icons.chevron_right),
            splashColor: couleurInstance.hexaToCouleur(config.theme).withOpacity(0.1),
            onTap: () {
              Navigator.pushNamed(context, '/compte/mdp');
            },
          ),
          SwitchListTile(
            activeColor: Colors.white,
            activeTrackColor: Theme.of(context).primaryColor,
            title: Text(
              "Mode sombre",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            value: isDark,
            onChanged: (val) async {
              config.setDarkMode(val);
            }
          ),
          ListTile(
            title: Text(
              "Thème de l'application",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Container(
              child: TextButton(
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Choisissez une couleur de thème',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: themeCouleur,
                          onColorChanged: (color) {
                            setState(() => themeCouleur = color);
                          },
                          showLabel: true,
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Annuler', style: TextStyle(color: Theme.of(context).primaryColor),),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        ElevatedButton(
                          child: Text('Appliquer', style: TextStyle(color: Theme.of(context).primaryColor),),
                          onPressed: () {
                            config.setTheme(couleurInstance.couleurEnHexa(themeCouleur));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              )
            )
          ),
          ListTile(
            title: Text(
              "Taille du police",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: ElevatedButton(
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (context) {
                    double taillePolice=config.taillePolice;

                    return StatefulBuilder(
                      builder: (context, setStateDialog) {
                        return AlertDialog(
                          title: Text(
                            'Personnaliser votre taille de police',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${taillePolice}"),
                                Slider(
                                  min: 12.0,
                                  max: 30.0,
                                  divisions: 18,
                                  value: taillePolice,
                                  label: "${taillePolice}",
                                  thumbColor: couleurInstance.hexaToCouleur(config.theme),
                                  activeColor: couleurInstance.hexaToCouleur(config.theme),
                                  onChanged: (value) {
                                    setStateDialog(() {
                                      taillePolice=value;
                                    });
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if(taillePolice > 12){
                                          setStateDialog(() {
                                            taillePolice--;
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.remove, color: couleurInstance.hexaToCouleur(config.theme)),
                                      splashColor: couleurInstance.hexaToCouleur(config.theme).withOpacity(0.1),
                                      highlightColor: couleurInstance.hexaToCouleur(config.theme).withOpacity(0.1),

                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if(taillePolice < 30){
                                          setStateDialog(() {
                                            taillePolice++;
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.add,  color: couleurInstance.hexaToCouleur(config.theme)),
                                      splashColor: couleurInstance.hexaToCouleur(config.theme).withOpacity(0.1),
                                      highlightColor: couleurInstance.hexaToCouleur(config.theme).withOpacity(0.1),
                                    )
                                  ],
                                )
                              ],
                            )
                          ),
                          actions: [
                            TextButton(
                              child: Text('Annuler', style: TextStyle(color: Theme.of(context).primaryColor),),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              child: Text('Appliquer', style: TextStyle(color: Theme.of(context).primaryColor),),
                              onPressed: () {
                                config.setTaillePolice(taillePolice);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }
                    );
                  }
                )
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(40, 40),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text('${config.taillePolice}', style: TextStyle(color: Theme.of(context).primaryColor),)
            )
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Bouton(texte: "Sauvegarder", taille: Size(50, 30), action: sauvegarder,)
          )
        ],
      )
  );
  }
}