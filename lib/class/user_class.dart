class User {
  final int _id;
  final String _role;
  final String _token;
  final String _email;
  final String _prenom;
  final String _nom;
  final String? _campus;

  User(this._id,this._role, this._email, this._token, this._prenom, this._nom,
     this._campus);

  int getId() {
    return _id;
  }

  String getRole() {
  return _role;
  }

  String getToken() {
    return _token;
  }

  String getEmail() {
    return _email;
  }

  String getPrenom() {
    return _prenom;
  }

  String getNom() {
    return _nom;
  }

  String? getCampus() {
    return _campus;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json['id'],
        json['role'],
        json['email'],
        json['token'],
        json['prenom'],
        json['name'],
        json['campus']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'role':_role,
      'token': _token,
      'email': _email,
      'prenom': _prenom,
      'name': _nom,
      'pays': _campus
    };
  }
}
