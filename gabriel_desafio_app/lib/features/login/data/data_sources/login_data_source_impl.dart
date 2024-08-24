import 'dart:async';

import '../../../../core/exceptions/exception.dart';
import '../models/user_model.dart';
import 'login_data_source.dart';

class LoginDataSourceImpl implements LoginDataSource {
  @override
  FutureOr<void> login(UserModel user) async {
    await Future.delayed(const Duration(seconds: 2));
    if (user.user == 'gabriel' && user.password == '140120') {
      return;
    }

    throw LoginExceptionDataSource(message: 'User data invalid');
  }
}
