import 'package:intl/intl.dart';

class User {
  final String pseudo;
  final String email;
  final DateTime? birthday;
  final String status;
  final DateTime registerdate;
  final int? idUser;

  User({required this.pseudo, required this.email, this.birthday, required this.status, required this.registerdate,
      this.idUser});

  /* keyword factory: permet d'instancier la classe User en manipulant en préalable les données (ajout de conditions si les paramètres sont null ou pas, parser une date...) */
  factory User.fromJson(Map<String, dynamic> json){
    String pseudo = json['pseudo'];
    String email = json['email'];
    String status = json['status'];
    DateFormat format = DateFormat("yyyy-MM-dd' HH:mm:ss");
    DateTime? birthday = json['birthday'] != null ? format.parse(json['birthday']) : null;
    DateTime registerDate = format.parse(json['registerdate']);
    int? idUser = json['individual_idindividual'] != null ? int.parse(json['individual_idindividual']) : null;
    return User(
      pseudo: pseudo,
      email: email,
      birthday: birthday,
      status: status,
      registerdate: registerDate,
      idUser: idUser
    );
  }
}
