import '../../../../core/exceptions/exception.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repository.dart';
import '../data_sources/login_data_source.dart';
import '../mapper/user_mapper.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _dataSource;

  LoginRepositoryImpl({required LoginDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<void> login(User user) async {
    try {
      final userModel = UserMapper.toModel(user);
      await _dataSource.login(userModel);
    } on LoginException {
      rethrow;
    } catch (e) {
      throw LoginExceptionRepository(message: 'Error on login', error: e);
    }
  }
}
