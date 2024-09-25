import 'dart:ffi';

class Topic {
  final int _id;
  final String _titre;
  final String _description;
  final DateTime _date;
  final String _utilisateur;
  final int _nbRep;

  Topic(this._id, this._titre, this._description, this._date,this._utilisateur,this._nbRep);

  int getId() {
    return _id;
  }
  String getTitre() {
    return _titre;
  }
  String getDescription() {
    return _description;
  }
  DateTime getDate() {
    return _date;
  }

  String getUtilisateur() {
    return _utilisateur;
  }

  int getNbRep() {
    return _nbRep;
  }
}