import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/produit.dart';

class ProduitAPI {
  Future<List<Produit>> listeProduits() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/produit/'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Produit.fromJson(json)).toList();
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<Produit> ajoutProduit(Map<String, dynamic> donnee) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.78:8000/api/produit/ajouter/'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: json.encode(donnee),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Produit.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<void> modifMultipleProduit(List<int> numProduits) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.78:8000/api/produit/produit-commande/'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: json.encode({"numProduits": numProduits}),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<Produit> modifProduit(
    Map<String, dynamic> donnee,
    int numProduit,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.43.78:8000/api/produit/modifier/$numProduit'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: json.encode(donnee),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Produit.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<Produit> uneProduit(String numProduit) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/produit/${numProduit}'),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Produit.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<Produit> produitCommandeApi() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/produit/produit-commande/'),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Produit.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<bool> verifierProduitApi(int numProduit, int quantite) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.78:8000/api/produit/verifier-produit/'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: {"numProduit": numProduit, "quantite": quantite},
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return data['valeur'];
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<void> suppressionProduit(int numProduit) async {
    try {
      final response = await http.delete(
        Uri.parse(
          'http://192.168.43.78:8000/api/produit/supprimer/${numProduit}',
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
