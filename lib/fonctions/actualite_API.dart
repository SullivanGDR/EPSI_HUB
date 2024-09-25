import 'dart:convert';
import 'package:epsi_hub/class/actualite.dart';
import 'package:epsi_hub/class/user_class.dart';
import 'package:http/http.dart' as http;

Future<List<Actualite>> initListActu(List<Actualite> listeActus) async {
  String baseUrl = '10.60.12.49';
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

      // Créer l'instance d'Actualite avec les informations de l'utilisateur
      Actualite actualite = Actualite(
        actualiteId,
        actualiteTitre,
        actualiteDescription,
        actualiteDate,
        actualiteUserNom,
        actualiteUserPrenom
      );

      listeActus.add(actualite); // Ajouter l'actualité à la liste
    }
    print("Chargement terminé !");
  } else {
    print("Erreur: ${response.statusCode} - ${response.reasonPhrase}");
  }
  return listeActus;
}
