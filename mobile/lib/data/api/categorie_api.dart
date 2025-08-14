import 'package:http/http.dart' as http;
import 'package:premier_app/core/utils/produit_utils.dart';
import 'package:premier_app/data/models/produit.dart';
import 'dart:convert';
import '../models/categorie.dart';
import 'dart:io';

class CategorieAPI {
  Future<List<Categorie>> listeCategories() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/categorie/'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Categorie.fromJson(json)).toList();
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<Categorie> ajoutCategorie(Map<String, dynamic> donnee) async {
    final uri = Uri.parse('http://192.168.43.78:8000/api/categorie/ajouter/');

    var request = http.MultipartRequest('POST', uri);
    request.fields['nomCategorie'] = donnee['nomCategorie'];
    request.fields['descCategorie'] = donnee['descCategorie'];
    request.headers.addAll({
      'Content-Type': 'multipart/form-data; charset=utf-8',
    });
    if (donnee['imageCategorie'] != null && donnee['imageCategorie'] is File) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'imageCategorie',
          (donnee['imageCategorie'] as File).path,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Categorie.fromJson(data);
    } else {
      final data = json.decode(response.body);
      throw Exception("Erreur : ${data['erreur'] ?? 'Erreur inconnue'}");
    }
  }

  Future<Categorie> modifCategorie(
    Map<String, dynamic> donnee,
    int numCategorie,
  ) async {
    final uri = Uri.parse(
      'http://192.168.43.78:8000/api/categorie/modifier/$numCategorie',
    );

    var request = http.MultipartRequest('PUT', uri);
    request.fields['nomCategorie'] = donnee['nomCategorie'];
    request.fields['descCategorie'] = donnee['descCategorie'];
    request.headers.addAll({
      'Content-Type': 'multipart/form-data; charset=utf-8',
    });
    if (donnee['imageCategorie'] != null && donnee['imageCategorie'] is File) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'imageCategorie',
          (donnee['imageCategorie'] as File).path,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Categorie.fromJson(data);
    } else {
      final data = json.decode(response.body);
      throw Exception("Erreur : ${data['erreur'] ?? 'Erreur inconnue'}");
    }
  }

  Future<Categorie> uneCategorie(String numCategorie) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/categorie/${numCategorie}'),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Categorie.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<List<Produit>> listeProduitCategorie(int numCategorie) async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://192.168.43.78:8000/api/categorie/produit/${numCategorie}',
        ),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return ProduitUtils.jsonVersModel(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    } catch (e) {
      throw Exception("Erreur : $e");
    }
  }

  Future<void> suppressionCategorie(int numCategorie) async {
    try {
      final response = await http.delete(
        Uri.parse(
          'http://192.168.43.78:8000/api/categorie/supprimer/${numCategorie}',
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
