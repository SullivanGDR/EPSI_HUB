class Actualite {
  final int id;
  final String titre;
  final String description;
  final DateTime date;

  Actualite(this.id, this.titre, this.description, this.date);

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