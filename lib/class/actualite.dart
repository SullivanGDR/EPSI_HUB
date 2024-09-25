import 'package:epsi_hub/class/user_class.dart';

class Actualite {
  final int id;
  final String titre;
  final String description;
  final DateTime date;
  final String userNom;
  final String userPrenom;

  Actualite(this.id, this.titre, this.description, this.date, this.userNom, this.userPrenom);

  int getId() {
    return id;
  }
  String getTitre() {
    return titre;
  }
  String getDescription() {
    return description;
  }
  DateTime getDate() {
    return date;
  }
}