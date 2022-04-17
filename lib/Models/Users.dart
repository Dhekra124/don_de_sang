class Cusers {
  String idUser;
  String CIN;
  String Nom;
  String Prenom;
  DateTime DateNais;
  String Adresse;
  String LieuNaiss;

  String Sexe;
  String TypeSang;

  String Genre;
  String Ville;
  double Poids;
  String Email;
  String Tel;

  Cusers({
    required this.idUser,
    required this.CIN,
    required this.Nom,
    required this.Prenom,
    required this.DateNais,
    required this.Ville,
    required this.Adresse,
    required this.LieuNaiss,
    required this.Sexe,
    required this.TypeSang,
    required this.Genre,
    required this.Email,
    required this.Tel,
    required this.Poids,
  });

  /*


  * */
// from json to object cusers

  factory Cusers.fromJson(Map<String, dynamic>? json) {
    return Cusers(
      idUser: json!["idUser"],
      CIN: json["CIN"],
      Nom: json["Nom"],
      Prenom: json["Prenom"],
      DateNais: json["DateNais"],
      Ville: json["Ville"],
      Adresse: json["Adresse"],
      LieuNaiss: json["LieuNaiss"],
      Sexe: json["Sexe"],
      TypeSang: json["TypeSang"],
      Genre: json["Genre"],
      Email: json["Email"],
      Tel: json["Tel"],
      Poids: json["Poids"],
    );
  }
// from object to json
  Map<String, dynamic> Tojson() {
    return {
      "idUser": idUser,
      "CIN": CIN,
      "Nom": Nom,
      "Genre": Genre,
      "Prenom": Prenom,
      "DateNais": DateNais,
      "Ville": Ville,
      "Adresse": Adresse,
      "LieuNaiss": LieuNaiss,
      "Sexe": Sexe,
      "TypeSang": TypeSang,
      "Email": Email,
      "Tel": Tel,
      "Poids": Poids,
    };
  }
}
