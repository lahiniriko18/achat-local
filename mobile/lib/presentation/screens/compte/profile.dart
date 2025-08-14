import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';
import 'package:premier_app/core/utils/app_utils.dart';
import 'package:premier_app/presentation/widgets/elements/input_widget.dart';
import 'package:premier_app/presentation/widgets/elements/elevatedbutton_widget.dart';
import 'package:premier_app/presentation/widgets/simple_appbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => ProfilePage();
}

class ProfilePage extends State<Profile> {
  final formDonnee = GlobalKey<FormState>();
  final TextEditingController nomControlleur = TextEditingController();
  final TextEditingController emailControlleur = TextEditingController();
  final TextEditingController contactControlleur = TextEditingController();
  final TextEditingController adresseControlleur = TextEditingController();

  bool isActive = false;

  void envoyerFormulaire() {
    if (formDonnee.currentState!.validate()) {
      // final email = emailControlleur.text;
      // final contact = contactControlleur.text;
      /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Connexion())
      );*/
    }
  }

  Couleur couleurInstance=Couleur();

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<Config>(context);
    final tailleIcon = config.taillePolice+5;
    return Scaffold(
      appBar: SimpleAppBar(titre: "Profile"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/user.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formDonnee,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Icon(
                            Icons.accessibility,
                            size: tailleIcon,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: InputWidget(
                            nomInput: "Nom",
                            inputControlleur: nomControlleur,
                            isOutline: false,
                            validation: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Veuillez entrer un nom';
                              }
                              if (val.trim().length < 3) {
                                return '3 caractère au moins';
                              }
                              return null;
                            },
                          )
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Icon(
                            Icons.mail,
                            size: tailleIcon,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: InputWidget(
                            nomInput: "Email",
                            inputControlleur: emailControlleur,
                            isOutline: false,
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
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Icon(
                            Icons.phone,
                            size: tailleIcon,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: InputWidget(
                            nomInput: "Contact",
                            inputControlleur: contactControlleur,
                            isOutline: false,
                            prefixe: "+261",
                            validation: (val) {
                              if (!(val == null || val.isEmpty) && (!RegExp(r'^\d{9}$').hasMatch(val.replaceAll(' ', '')))) {
                                return 'Le numéro doit contenir exactement 9 chiffres';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Icon(
                            Icons.location_on,
                            size: tailleIcon,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: InputWidget(
                            nomInput: "Adresse",
                            inputControlleur: adresseControlleur,
                            isOutline: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SimpleBouton(texte: "Enregistrer", action: envoyerFormulaire,),
                        SimpleBouton(
                          texte: "Modifier le mot de passe",
                          action: () {
                            Navigator.pushNamed(context, '/compte/mdp');
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}