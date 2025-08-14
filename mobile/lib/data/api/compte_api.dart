import 'package:http/http.dart' as http;
import 'package:premier_app/configuration/config.dart';
import 'dart:convert';

class CompteAPI {
  final Config config = Config();
  Future<Map<String, dynamic>> connexionApi(String username, String mdp) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.78:8000/api/user/connexion/'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode({'username': username, 'password': mdp}),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        final data = json.decode(response.body);
        throw Exception(data['detail'] ?? "Connexion échouée");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<Map<String, dynamic>> inscriptionApi(
    String username,
    String email,
    String mdp,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.78:8000/api/user/inscription/'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode({'username': username, email: email, 'password': mdp}),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        final data = json.decode(response.body);
        throw Exception(data['detail'] ?? "Inscription échouée");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<void> refreshTokenApi() async {
    final refresh = config.refresh;
    print(config.accessToken);
    print(config.refresh);
    if (refresh == null) throw Exception("Aucun refresh token trouvé");

    final response = await http.post(
      Uri.parse('http://192.168.43.78:8000/api/user/token/refresh/'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode({'refresh': refresh}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      config.setAccess(data['access']!);
    } else {
      throw Exception("Échec du renouvellement du token");
    }
  }
}
