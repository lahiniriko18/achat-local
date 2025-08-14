import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:premier_app/data/models/image.dart';

class ImageAPI {
  Future<ImageProduit> ajoutImage(Map<String, dynamic> donnee) async {
    final uri = Uri.parse('http://192.168.43.78:8000/api/image/ajouter/');

    var request = http.MultipartRequest('POST', uri);
    request.fields['numProduit'] = donnee['numProduit'].toString();
    request.headers.addAll({
      'Content-Type': 'multipart/form-data; charset=utf-8',
    });
    if (donnee['nomImage'] != null && donnee['nomImage'] is File) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'nomImage',
          (donnee['nomImage'] as File).path,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ImageProduit.fromJson(data);
    } else {
      final data = json.decode(response.body);
      throw Exception("Erreur : ${data['erreur'] ?? 'Erreur inconnue'}");
    }
  }

  Future<ImageProduit> modifImage(Map<String, dynamic> donnee) async {
    final uri = Uri.parse('http://192.168.43.78:8000/api/image/modifier/');

    var request = http.MultipartRequest('PUT', uri);
    request.fields['numProduit'] = donnee['numProduit'].toString();
    request.headers.addAll({
      'Content-Type': 'multipart/form-data; charset=utf-8',
    });
    if (donnee['nomImage'] != null && donnee['nomImage'] is File) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'nomImage',
          (donnee['nomImage'] as File).path,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ImageProduit.fromJson(data);
    } else {
      final data = json.decode(response.body);
      throw Exception("Erreur : ${data['erreur'] ?? 'Erreur inconnue'}");
    }
  }

  Future<void> suppressionImage(int numImage) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.43.78:8000/api/image/supprimer/${numImage}'),
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
