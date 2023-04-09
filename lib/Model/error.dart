import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable()
class ErrorData {
  String? message;
  Errors? errors;

  ErrorData({this.message, this.errors});

  factory ErrorData.fromJson(Map<String, dynamic> json) {
    return _$ErrorDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ErrorDataToJson(this);
  }
}

@JsonSerializable()
class Errors {
  List<String>? name;
  List<String>? email;
  List<String>? password;

  Errors({this.name, this.email, this.password});

  factory Errors.fromJson(Map<String, dynamic> json) {
    return _$ErrorsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ErrorsToJson(this);
  }
}
