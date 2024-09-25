import 'dart:convert';
import 'package:epsi_hub/class/events.dart';
import 'package:http/http.dart' as http;

Future<List<Event>> initListevent(List<Event> listeEvents) async {
  String baseUrl = '192.168.1.34';
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
      Event champion = Event(eventId, eventTitre, eventDescription,eventDate,campus);
      print(champion);
      listeEvents.add(champion);
    }
    print("Chargement terminé !");
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeEvents;
}
