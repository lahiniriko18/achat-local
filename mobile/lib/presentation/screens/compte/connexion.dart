import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';
import 'package:premier_app/core/utils/app_utils.dart';
import 'package:premier_app/presentation/widgets/elements/curveclipper_widget.dart';
import 'package:premier_app/presentation/widgets/elements/input_widget.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';
import 'package:premier_app/presentation/widgets/elements/dialog_widget.dart';
// import 'package:premier_app/data/repositories/compte_repos.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});
  @override
  ConnexionPageState createState() => ConnexionPageState();
}

class ConnexionPageState extends State<Connexion> {
  final formDonnee = GlobalKey<FormState>();
  final TextEditingController usernmaeControlleur = TextEditingController();
  final TextEditingController mdpControlleur = TextEditingController();

  bool cache = true;
  Couleur couleurInstance=Couleur();


  Future<void> envoyerVersApi() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ChargementDialog(message: "Veuillez patienter ...")
    );
    // final donnee ={
    //   "username":usernmaeControlleur.text,
    //   "mdp":mdpControlleur.text
    // };
    try {
      // final data = await CompteRepos().connexion(donnee['username']!, donnee['mdp']!);
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, '/');
    } catch(e) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (_) => MessageDialog(titre: "Erreur", message: e.toString())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final config=Provider.of<Config>(context);
    final hauteurEcran=MediaQuery.of(context).size;

    void envoyerFormulaire() {
      if (formDonnee.currentState!.validate()) {
        envoyerVersApi();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                height: hauteurEcran.height * 0.40,
                color: couleurInstance.hexaToCouleur(config.theme),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle, color: Colors.white, size: 60),
                      SizedBox(height: 5),
                      Text(
                        'CONNEXION',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                key: formDonnee,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputWidget(
                      nomInput: "Nom",
                      inputControlleur: usernmaeControlleur,
                      isOutline: true,
                      validation: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        else if(val.trim().length < 3){
                          return "3 caractères minimum";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    InputWidget(
                      nomInput: "Mot de passe",
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
                    Bouton(texte: "Se connecter", taille: Size(200, 50), action: envoyerFormulaire,),
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Vous n'avez pas une compte ?  ",
                          style: TextStyle(
                            fontSize: config.taillePolice - 1,
                          )
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/inscription');
                          },
                          splashColor: Colors.blue.withOpacity(0.1),
                          highlightColor: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          child: Text(
                            "S'inscrire",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: config.taillePolice - 1
                            )
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
