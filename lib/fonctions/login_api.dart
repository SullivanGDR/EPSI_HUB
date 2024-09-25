import 'dart:convert';
import 'package:epsi_hub/class/user_class.dart';
import 'package:http/http.dart' as http;


Future<User?> login(email, mdp) async {
  String baseUrl = '10.60.12.49';
  Map<String, String> header = {
    "Content-type": "application/json",
    "Accept": 'application/json',
  };
  final uri = Uri.http(baseUrl, '/api/authentication_token');

  final response = await http.post(
    uri,
    headers: header,
    body: jsonEncode({"email": email, "password": mdp}),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    var user = User(
        data["data"]["id"],
        data["data"]["mail"],
        data["token"],
        data["data"]["prenom"],
        data["data"]["nom"],
        data["data"]["campus"]);
    return user;
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    return null;
  }
}

Future<bool> isLogin(token, id) async {
  String baseUrl = '10.60.12.49';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/ld+json',
    'Authorization': "Bearer $token"
  };
  final uri = Uri.http(baseUrl, '/GDSport/public/api/users/$id');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    print("est connecté");
    return true;
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    return false;
  }
}