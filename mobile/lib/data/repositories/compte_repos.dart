import 'package:premier_app/data/api/compte_api.dart';
import 'package:premier_app/configuration/config.dart';

class CompteRepos {
  final Config config = Config();
  Future<Map<String, dynamic>> connexion(String username, String mdp) {
    return CompteAPI().connexionApi(username, mdp);
  }
  Future<Map<String, dynamic>> inscription(String username, String email, String mdp) {
    return CompteAPI().inscriptionApi(username, email, mdp);
  }
  Future<void> refreshToken() {
    return CompteAPI().refreshTokenApi();
  }
}