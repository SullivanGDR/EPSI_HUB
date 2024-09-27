class Signalement {
  final int id;
  final String titre;
  final String description;
  final DateTime date;
  final String status;
  final String nomUser;
  final String prenomUser;

  Signalement(this.id, this.titre, this.description, this.date, this.status, this.nomUser, this.prenomUser);

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
  String getStatus() {
    return status;
  }
}