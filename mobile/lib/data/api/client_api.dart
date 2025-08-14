import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/client.dart';

class ClientAPI {
  Future<List<Client>> listeClients() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/client/'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Client.fromJson(json)).toList();
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<Client> ajoutClient(Map<String, dynamic> donnee) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.78:8000/api/client/ajouter/'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: json.encode(donnee),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Client.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<Client> modifClient(Map<String, dynamic> donnee, int numClient) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.43.78:8000/api/client/modifier/$numClient'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: json.encode(donnee),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Client.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<Client> uneClient(String numClient) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/client/${numClient}'),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Client.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<void> suppressionClient(int numClient) async {
    try {
      final response = await http.delete(
        Uri.parse(
          'http://192.168.43.78:8000/api/client/supprimer/${numClient}',
        ),
      );
      if (response.statusCode != 204 && response.statusCode != 200) {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }
}
