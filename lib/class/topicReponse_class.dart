class TopicR {
  final String _message;
  final DateTime _date;
  final String _utilisateur;

  TopicR(this._message, this._date,this._utilisateur);

  String getMessage() {
    return _message;
  }
  DateTime getDate() {
    return _date;
  }
  String getUtilisateur() {
    return _utilisateur;
  }
}