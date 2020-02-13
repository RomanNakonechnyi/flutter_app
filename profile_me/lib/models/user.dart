class User{
  final int id;
  final String fullName;
  final String password;
  final String login;
  User({this.id,this.fullName, this.password, this.login});

  factory User.fromJson(Map<String, dynamic> json){
    return new User(
        id: json['id'],
        fullName: json['fullname'],
        password: json['password'],
        login: json['login'],
    );
  }

  Map<String,dynamic> toJson() =>
      {
        'id': id,
        'fullname': fullName,
        'password': password,
        'login': login
      };

  @override
  String toString() {
    return 'User(id: $id, name: $fullName, password: $password, login: $login)';
  }
}
