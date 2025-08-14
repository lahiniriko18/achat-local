import '../api/Classement_api.dart';
import '../models/classement.dart';

class ClassementRepos {
  Future<List<Classement>> tousClassements() {
    return ClassementAPI().listeClassements();
  }

  Future<Classement> uneClassement(String numClassement) {
    return ClassementAPI().uneClassement(numClassement);
  }

}