import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';
import 'package:premier_app/core/utils/app_utils.dart';
import 'package:premier_app/presentation/widgets/elements/curveclipper_widget.dart';
import 'package:premier_app/presentation/widgets/elements/input_widget.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';
import 'package:premier_app/presentation/widgets/elements/dialog_widget.dart';
// import 'package:premier_app/data/repositories/compte_repos.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});
  @override
  InscriptionPageState createState() => InscriptionPageState();
}

class InscriptionPageState extends State<Inscription> {
  final formDonnee = GlobalKey<FormState>();
  final TextEditingController nomControlleur = TextEditingController();
  final TextEditingController emailControlleur = TextEditingController();
  final TextEditingController mdpControlleur = TextEditingController();
  final TextEditingController mdpConfirmControlleur = TextEditingController();
  bool cache = true;
  bool cacheConfirm = true;
  Couleur couleurInstance=Couleur();

  Future<void> envoyerVersApi() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ChargementDialog(message: "Veuillez patienter ...")
    );
    // final donnee ={
    //   "username":nomControlleur.text,
    //   "email":emailControlleur.text,
    //   "mdp":mdpControlleur.text
    // };
    try {
      // final data = await CompteRepos().inscription(donnee['username']!, donnee['email']!, donnee['mdp']!);
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, '/connexion');
    } catch(e) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (_) => MessageDialog(titre: "Erreur", message: e.toString())
      );
    }
  }

  void envoyerFormulaire() {
    if (formDonnee.currentState!.validate()) {
      envoyerVersApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    final config=Provider.of<Config>(context);
    final hauteurEcran=MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                height: hauteurEcran.height * 0.25,
                color: couleurInstance.hexaToCouleur(config.theme),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'INSCRIPTION',
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
                      inputControlleur: nomControlleur,
                      isOutline: true,
                      validation: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Veuillez entrer un nom';
                        }
                        if (val.trim().length < 3) {
                          return '3 caractère au moins';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
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
                    InputWidget(
                      nomInput: "Confirmer le mot de passe",
                      inputControlleur: mdpConfirmControlleur,
                      cache: true,
                      isOutline: true,
                      validation: (val) {
                        if (val == null || val.trim().length < 6) {
                          return '6 caractères minimum';
                        }
                        else if (val != mdpControlleur.text){
                          return 'Mot de passe ne correspond pas!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Bouton(texte: "S'inscrire", taille: Size(200, 50), action: envoyerFormulaire,),
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Avez-vous une compte ?  ",
                          style: TextStyle(fontSize: config.taillePolice - 1)
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/connexion');
                          },
                          splashColor: Colors.blue.withOpacity(0.1),
                          highlightColor: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          child: Text(
                            "Se connecter",
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
      )
    );
  }
}
