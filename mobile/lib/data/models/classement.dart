
import 'dart:ffi';

class Classement {
  int numClassement;
  String nomClassement;
  Double quantiteMin;
  Double quantiteMax;
  String descClassement;

  Classement({
    required this.numClassement,
    required this.nomClassement,
    required this.quantiteMin,
    required this.quantiteMax,
    required this.descClassement
  });

  factory Classement.fromJson(Map<String, dynamic> classement) {
    return Classement(
      numClassement: classement['numClassement'], 
      nomClassement: classement['nomClassement'],
      quantiteMin: classement['quantiteMin'],
      quantiteMax: classement['quantiteMax'],
      descClassement: classement['descClassement']
      );
  }
}