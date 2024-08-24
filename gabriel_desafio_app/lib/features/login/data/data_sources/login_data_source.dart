import 'dart:async';

import '../models/user_model.dart';

abstract interface class LoginDataSource {
  FutureOr<void> login(UserModel user);
}
