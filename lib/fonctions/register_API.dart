import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> register(email, mdp, nom, prenom,campus) async {
  String baseUrl = '81.49.122.157';
  Map<String, String> header = {
    "Content-type": "application/ld+json",
    "Accept": 'application/ld+json',
  };
  final uri = Uri.http(baseUrl,'/api/users');

  final response = await http.post(
    uri,
    headers: header,
    body: jsonEncode({
      "email": email,
      "password": mdp,
      "nom": nom,
      "prenom": prenom,
      "campus": 'http://10.60.12.49/api/campuses/$campus'
    }),
  );

  if (response.statusCode == 201) {
    print("compte créé");
    return true;
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    return false;
  }
}
