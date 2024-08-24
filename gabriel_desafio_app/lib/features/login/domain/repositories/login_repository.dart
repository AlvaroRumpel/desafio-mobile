import '../entities/user.dart';

abstract interface class LoginRepository {
  Future<void> login(User user);
}
