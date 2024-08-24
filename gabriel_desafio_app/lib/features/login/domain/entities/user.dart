import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String user;
  final String password;

  const User({required this.user, required this.password});

  @override
  List<Object?> get props => [user, password];
}
