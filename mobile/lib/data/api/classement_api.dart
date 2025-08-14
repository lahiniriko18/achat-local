import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/classement.dart';

class ClassementAPI {
  Future<List<Classement>> listeClassements() async {
    try{
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/classement/'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Classement.fromJson(json)).toList();
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    }
    catch (e){
      throw Exception("Erreur : $e");
    }
  }
  Future<Classement> uneClassement(String numClassement) async {
    try{
      final response = await http.get(
        Uri.parse('http://192.168.43.78:8000/api/classement/${numClassement}'),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return Classement.fromJson(data);
      } else {
        final data = json.decode(response.body);
        throw Exception("Erreur : ${data['erreur']}");
      }
    }
    catch (e){
      throw Exception("Erreur : $e");
    }
  }
}