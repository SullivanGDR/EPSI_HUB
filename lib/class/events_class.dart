class Event {
  final int id;
  final String titre;
  final String description;
  final DateTime date;
  final String campus;

  Event(this.id, this.titre, this.description, this.date,this.campus);

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
  String getCampus() {
    return campus;
  }
}