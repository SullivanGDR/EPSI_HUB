import 'dart:convert';
import 'package:epsi_hub/class/signalement.dart';
import 'package:http/http.dart' as http;

Future<List<Signalement>> initListSignalement(List<Signalement> listeSignalement) async {
  String baseUrl = '10.60.12.49';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/api/reports');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final List dataList = json.decode(response.body)['member'];

    for (var signalement in dataList) {
      final int id = signalement['id'];
      final String titre = signalement['titre'];
      final String description = signalement['description'];
      final DateTime date = DateTime.parse(signalement['date']);
      final String status = signalement['status'];
      final String nomUser = signalement['user']['nom'];
      final String prenomUser = signalement['user']['prenom'];

      // Créer l'instance d'Actualite avec les informations de l'utilisateur
      Signalement report = Signalement(id, titre, description, date, status, nomUser, prenomUser);

      listeSignalement.add(report); // Ajouter l'actualité à la liste
    }
    print("Chargement terminé !");
  } else {
    print("Erreur: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeSignalement;
}


Future<List<Signalement>> initListSignalementUser(List<Signalement> listeSignalement,int id) async {
  String baseUrl = '10.60.12.49';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/api/reports', {'user': id.toString()});

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final List dataList = json.decode(response.body)['member'];

    for (var signalement in dataList) {
      final int id = signalement['id'];
      final String titre = signalement['titre'];
      final String description = signalement['description'];
      final DateTime date = DateTime.parse(signalement['date']);
      final String status = signalement['status'];
      final String nomUser = signalement['user']['nom'];
      final String prenomUser = signalement['user']['prenom'];

      // Créer l'instance d'Actualite avec les informations de l'utilisateur
      Signalement report = Signalement(id, titre, description, date, status, nomUser, prenomUser);

      listeSignalement.add(report); // Ajouter l'actualité à la liste
    }
    print("Chargement terminé !");
  } else {
    print("Erreur: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeSignalement;
}