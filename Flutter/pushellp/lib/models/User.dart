import 'package:intl/intl.dart';

class User {
  final int idUser;
  final String pseudo;
  final String email;
  final DateTime? birthday;
  final String status;
  final DateTime registerdate;
  final int? idUserFK;

  User({required this.idUser,required this.pseudo, required this.email, this.birthday, required this.status, required this.registerdate,
      this.idUserFK});

  /* keyword factory: permet d'instancier la classe User en manipulant en préalable les données (ajout de conditions si les paramètres sont null ou pas, parser une date...) */
  factory User.fromJson(Map<String, dynamic> json){
    int id = json['idindividual'];
    String pseudo = json['pseudo'];
    String email = json['email'];
    String status = json['status'];
    DateFormat format = DateFormat("yyyy-MM-dd' HH:mm:ss");
    DateTime? birthday = json['birthday'] != null ? format.parse(json['birthday']) : null;
    DateTime registerDate = format.parse(json['registerdate']);
    int? idUser = json['individual_idindividual'] != null ? json['individual_idindividual'] : null;
    return User(
      idUser: id,
      pseudo: pseudo,
      email: email,
      birthday: birthday,
      status: status,
      registerdate: registerDate,
      idUserFK: idUser
    );
  }
  String toString() {
    return "User(id: $idUser, pseudo: $pseudo, email: $email, birthday: $birthday, status: $status, registerdate: $registerdate, idUserFK: $idUserFK)";
  }
}
