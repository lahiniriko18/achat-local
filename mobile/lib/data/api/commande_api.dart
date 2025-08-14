import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/commande.dart';

class CommandeAPI {
  Future<List<Commande>> listeCommandes() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/commande/'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Commande.fromJson(json)).toList();
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      print("Erreur be: $e");
      throw Exception("Erreur be: $e");
    }
  }

  Future<Commande> ajoutCommande(Map<String, dynamic> donnee) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.78:8000/api/commande/ajouter/'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: json.encode(donnee),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Commande.fromJson(data);
      } else {
        final data = json.decode(response.body);
        print(data);
        throw Exception("Erreur : ${data['error']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<Commande> dernierCommandeApi() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/commande/dernier-commande/'),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Commande.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<void> suppressionCommande(int numCommande) async {
    try {
      final response = await http.delete(
        Uri.parse(
          'http://192.168.43.78:8000/api/commande/supprimer/${numCommande}',
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
