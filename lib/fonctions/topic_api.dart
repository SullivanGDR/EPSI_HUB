import 'dart:convert';
import 'dart:ffi';
import 'package:epsi_hub/class/topic_class.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<List<Topic>> initListTopic(List<Topic> listeTopics) async {
  String baseUrl = '10.60.12.49';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/api/topics');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final List dataList = json.decode(response.body)['member'];
    for (var topic in dataList) {
      final int Id = topic['id'];
      final String Titre = topic['titre'];
      final String Description = topic['message'];
      final DateTime Date = DateTime.parse(topic['date']);
      final String utilisateur = topic['user']['nom']+' '+topic['user']['prenom'];
      final List Rep = topic['topicReponses'];
      Topic champion = Topic(Id, Titre, Description,Date,utilisateur,Rep.length);
      print(champion);
      listeTopics.add(champion);
    }
    print("Chargement terminé !");
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeTopics;
}


Future<bool> addTopic(titre, message,id) async {
  String baseUrl = '10.60.12.49';
  Map<String, String> header = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl, '/api/topics');

  final response = await http.post(
    uri,
    headers: header,
    body: jsonEncode({
      "titre": titre,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "message": message,
      "user": 'http://10.60.12.49/api/users/$id'
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
