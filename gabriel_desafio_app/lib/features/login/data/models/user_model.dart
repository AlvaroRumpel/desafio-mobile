import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String user;
  final String password;

  const UserModel({required this.user, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user: map['user'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [user, password];
}
