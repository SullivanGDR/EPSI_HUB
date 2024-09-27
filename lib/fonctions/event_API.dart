import 'dart:convert';
import 'package:epsi_hub/class/events_class.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<List<Event>> initListevent(List<Event> listeEvents) async {
  String baseUrl = '10.60.12.45';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/api/events');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final List dataList = json.decode(response.body)['member'];
    for (var event in dataList) {
      final int eventId = event['id'];
      final String eventTitre = event['titre'];
      final String eventDescription = event['description'];
      final DateTime eventDate = DateTime.parse(event['date']);
      final String campus = event['ecole']['libelle'];
      Event newEvent = Event(eventId, eventTitre, eventDescription,eventDate,campus);
      print(newEvent);
      listeEvents.add(newEvent);
    }
    print("Chargement terminé !");
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeEvents;
}

Future<void> createEvent(int idType, String description, String titre, int idCampus, DateTime date) async {
  String baseUrl = '10.60.12.45';
  Map<String, String> header = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/api/events');

  try {
    Map<String, dynamic> jsonData = {
      "titre": titre,
      "date": DateFormat('yyyy-MM-dd').format(date),
      "description": description,
      "type": "http://10.60.12.45/api/event_types/$idType",
      "ecole": "http://10.60.12.45/api/campuses/$idCampus",
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
