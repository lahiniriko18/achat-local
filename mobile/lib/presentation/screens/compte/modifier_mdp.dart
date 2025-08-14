import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';
import 'package:premier_app/core/utils/app_utils.dart';
import 'package:premier_app/presentation/widgets/elements/input_widget.dart';
import 'package:premier_app/presentation/widgets/simple_appbar.dart';

class Modifiermdp extends StatefulWidget {
  const Modifiermdp({super.key});
  @override
  ModifiermdpPage createState() => ModifiermdpPage();
}

class ModifiermdpPage extends State<Modifiermdp> {
  final formDonnee = GlobalKey<FormState>();
  final TextEditingController emailControlleur = TextEditingController();
  final TextEditingController oldMdpControlleur = TextEditingController();
  final TextEditingController mdpControlleur = TextEditingController();
  final TextEditingController mdpConfirmControlleur = TextEditingController();
  Couleur couleurInstance=Couleur();

  void envoyerFormulaire() {
    if (formDonnee.currentState!.validate()) {
      // final email = emailControlleur.text;
      // final motDePasse = mdpControlleur.text;
      /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Connexion())
      );*/
    }
  }

  @override
  Widget build(BuildContext context) {
    final config=Provider.of<Config>(context);
    Color couleurTexte = couleurInstance.couleurMode(config.isDark);
    return Scaffold(
      appBar: SimpleAppBar(titre: "Mot de passe"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                key: formDonnee,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Modification de mot de passe",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: couleurTexte,
                              fontSize: config.taillePolice + 2
                            ),
                          ),
                          Container(
                            color: couleurTexte,
                            height: 2,
                            width: 100,
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 20,),
                    InputWidget(
                      nomInput: "Email",
                      inputControlleur: emailControlleur,
                      isOutline: true,
                      validation: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Veuillez entrer un email';
                        }
                        if (!val.contains('@')) {
                          return 'Email invalide';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    InputWidget(
                      nomInput: "Ancien mot de passe",
                      inputControlleur: oldMdpControlleur,
                      cache: true,
                      isOutline: true,
                      validation: (val) {
                        if (val == null || val.trim().length < 6) {
                          return '6 caractères minimum';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    InputWidget(
                      nomInput: "Nouveau mot de passe",
                      inputControlleur: mdpControlleur,
                      cache: true,
                      isOutline: true,
                      validation: (val) {
                        if (val == null || val.trim().length < 6) {
                          return '6 caractères minimum';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    InputWidget(
                      nomInput: "Confirmer",
                      inputControlleur: mdpConfirmControlleur,
                      cache: true,
                      isOutline: true,
                      validation: (val) {
                        if (val == null || val.trim().length < 6) {
                          return '6 caractères minimum';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: envoyerFormulaire,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: couleurInstance.hexaToCouleur(config.theme),
                        foregroundColor: Colors.white,
                        minimumSize: Size(200, 50),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        shadowColor: Colors.black,
                        elevation: 5,
                      ),
                      child: Text(
                        "Enregistrer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
