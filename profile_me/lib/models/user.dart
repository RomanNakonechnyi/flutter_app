import 'credentials.dart';

class User{
  final String fullName;
  final String password;
  final String login;
  User({this.fullName, this.password, this.login});

  factory User.fromJson(Map<String, dynamic> json){
    return new User(
        fullName: json['name'],
        password: json['password'],
        login: json['login'],
    );
  }
  Map<String, dynamic> toJson() =>
      {
        'name': fullName,
        'password': password,
        'login': login
      };
}
