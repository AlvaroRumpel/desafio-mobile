import '../../../../core/exceptions/exception.dart';
import '../entities/user.dart';
import '../repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository _repository;

  LoginUsecase({required LoginRepository repository})
      : _repository = repository;

  Future<void> login({required String user, required String password}) async {
    try {
      if (user.isEmpty || password.isEmpty) {
        throw LoginExceptionUsecase(
          message: 'Dados incompletos, por favor revise as informações',
        );
      }

      final entity = User(user: user, password: password);
      await _repository.login(entity);
    } catch (e) {
      if (e is LoginExceptionUsecase) {
        rethrow;
      }

      throw LoginExceptionUsecase(
        message: 'Usuário ou senha incorretos, por favor revise as informações',
        error: e,
      );
    }
  }
}
