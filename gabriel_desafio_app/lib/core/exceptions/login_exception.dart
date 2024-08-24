import 'custom_exception.dart';

abstract class LoginException extends CustomException {
  LoginException({super.message, super.error}) : super(prefix: 'Login Error: ');
}

class LoginExceptionDataSource extends LoginException {
  LoginExceptionDataSource({required String message, super.error}) : super();
}

class LoginExceptionRepository extends LoginException {
  LoginExceptionRepository({required String message, super.error}) : super();
}

class LoginExceptionUsecase extends LoginException {
  LoginExceptionUsecase({required String message, super.error}) : super();
}
