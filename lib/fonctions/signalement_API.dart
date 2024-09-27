import 'dart:convert';
import 'package:epsi_hub/class/signalement_class.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<List<Signalement>> initListSignalement(List<Signalement> listeSignalement) async {
  String baseUrl = '81.49.122.157';
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

      Signalement report = Signalement(id, titre, description, date, status, nomUser, prenomUser);

      listeSignalement.add(report);
    }
    print("Chargement terminé !");
  } else {
    print("Erreur: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeSignalement;
}

Future<List<Signalement>> initListSignalementUser(List<Signalement> listeSignalement,int id) async {
  String baseUrl = '81.49.122.157';
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

      Signalement report = Signalement(id, titre, description, date, status, nomUser, prenomUser);

      listeSignalement.add(report);
    }
    print("Chargement terminé !");
  } else {
    print("Erreur: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeSignalement;
}

Future<bool> addSignalement(titre, description,id) async {
  String baseUrl = '81.49.122.157';
  Map<String, String> header = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/api/reports');

  final response = await http.post(
    uri,
    headers: header,
    body: jsonEncode({
      "titre": titre,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "description": description,
      "status" : "en cours",
      "user" : 'http://192.168.1.34/api/users/$id'
    }),
  );

  if (response.statusCode == 201) {
    print("topic créé");
    return true;
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    return false;
  }
}