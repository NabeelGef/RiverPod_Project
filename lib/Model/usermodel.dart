import 'package:json_annotation/json_annotation.dart';
part 'usermodel.g.dart';

@JsonSerializable()
class Users {
  User? user;
  String? token;

  Users({this.user, this.token});

  factory Users.fromJson(Map<String, dynamic> json) {
    return _$UsersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UsersToJson(this);
  }
}

@JsonSerializable()
class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? confirmpassword;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.confirmpassword});

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}
