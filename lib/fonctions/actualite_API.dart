import 'dart:convert';
import 'package:epsi_hub/class/actualite_class.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<List<Actualite>> initListActu(List<Actualite> listeActus) async {
  String baseUrl = '10.60.12.45';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/api/actualites');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final List dataList = json.decode(response.body)['member'];

    for (var actualiteJson in dataList) {
      final int actualiteId = actualiteJson['id'];
      final String actualiteTitre = actualiteJson['titre'];
      final String actualiteDescription = actualiteJson['description'];
      final DateTime actualiteDate = DateTime.parse(actualiteJson['date']);
      final String actualiteUserNom = actualiteJson['user']['nom'];
      final String actualiteUserPrenom = actualiteJson['user']['prenom'];
      final String campus = actualiteJson['campus']['libelle'];

      Actualite actualite = Actualite(
        actualiteId,
        actualiteTitre,
        actualiteDescription,
        actualiteDate,
        actualiteUserNom,
        actualiteUserPrenom,
        campus
      );

      listeActus.add(actualite);
    }
    print("Chargement terminé !");
  } else {
    print("Erreur: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeActus;
}

Future<void> createActu(int idUser, String description, String titre, int idCampus) async {
  String baseUrl = '10.60.12.45';
  Map<String, String> header = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/api/actualites');

  try {
    Map<String, dynamic> jsonData = {
      "description": description,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "titre": titre,
      "user": "http://10.60.12.45/api/users/$idUser",
      "campus": "http://10.60.12.45/api/campuses/$idCampus",
    };

    final response = await http.post(
      uri,
      headers: header,
      body: jsonEncode(jsonData),
    );

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print("Actualité créée avec succès!");
      }
    } else {
      if (kDebugMode) {
        print("Erreur lors de la création de l'actualité: ${response.statusCode} - ${response.reasonPhrase}");
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print("Erreur lors de la création de l'actualité: $error");
    }
  }
}
