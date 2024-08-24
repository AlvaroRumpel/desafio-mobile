import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/core/exceptions/exception.dart';
import 'package:gabriel_desafio_app/features/login/data/data_sources/login_data_source_impl.dart';
import 'package:gabriel_desafio_app/features/login/data/mapper/user_mapper.dart';
import 'package:gabriel_desafio_app/features/login/data/models/user_model.dart';
import 'package:gabriel_desafio_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:gabriel_desafio_app/features/login/domain/entities/user.dart';
import 'package:gabriel_desafio_app/features/login/domain/usecases/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginDataSource extends Mock implements LoginDataSourceImpl {}

class MockLoginRepository extends Mock implements LoginRepositoryImpl {}

void main() {
  const userModelAuth = UserModel(user: 'gabriel', password: '140120');
  const userModelWrong = UserModel(
    user: 'wrongUser',
    password: 'wrongPassword',
  );

  group('UserMapper', () {
    test('should map UserModel to User correctly', () {
      // Given
      const userModel = UserModel(user: 'user', password: '12345678');

      // When
      final user = UserMapper.toEntity(userModel);

      // Then
      expect(user.user, 'user');
      expect(user.password, '12345678');
    });

    test('should map User to UserModel correctly', () {
      // Given
      const user = User(user: 'user', password: '12345678');

      // When
      final userModel = UserMapper.toModel(user);

      // Then
      expect(userModel.user, 'user');
      expect(userModel.password, '12345678');
    });
  });

  group('LoginDataSourceImpl', () {
    final loginDataSource = LoginDataSourceImpl();

    test('login should succeed with valid credentials', () async {
      // Given
      const user = userModelAuth;

      // When
      expect(loginDataSource.login(user), completes);
    });

    test('login should throw LoginException with invalid credentials',
        () async {
      // Given
      const invalidUser = userModelWrong;

      // When
      expect(
        () async => await loginDataSource.login(invalidUser),
        throwsA(isA<LoginException>()),
      );
    });
  });

  group('LoginRepositoryImpl', () {
    late MockLoginDataSource mockLoginDataSource;
    late LoginRepositoryImpl loginRepository;

    setUp(() {
      mockLoginDataSource = MockLoginDataSource();
      loginRepository = LoginRepositoryImpl(dataSource: mockLoginDataSource);
    });

    test('login should succeed when data source login is successful', () async {
      // Given
      final user = UserMapper.toEntity(userModelAuth);
      final userModel = UserMapper.toModel(user);

      // Correctly mock the login method to return Future<void>
      when(() => mockLoginDataSource.login(userModel))
          .thenAnswer((_) async => Future<void>.value());

      // When
      expect(loginRepository.login(user), completes);

      // Then
      verify(() => mockLoginDataSource.login(userModel)).called(1);
    });

    test('login should throw LoginException when data source throws exception',
        () async {
      // Given
      final user = UserMapper.toEntity(userModelWrong);
      final userModel = UserMapper.toModel(user);

      when(() => mockLoginDataSource.login(userModel)).thenThrow(
        LoginExceptionDataSource(message: 'Invalid credentials'),
      );

      // When & Then
      expect(
        loginRepository.login(user),
        throwsA(isA<LoginException>()),
      );
    });
  });

  group('LoginUsecase', () {
    late MockLoginRepository mockLoginRepository;
    late LoginUsecase loginUsecase;

    setUp(() {
      mockLoginRepository = MockLoginRepository();
      loginUsecase = LoginUsecase(repository: mockLoginRepository);
    });

    test('should call repository login when user and password are provided',
        () async {
      // Given
      const user = 'gabriel';
      const password = '140120';
      const entity = User(user: user, password: password);

      when(() => mockLoginRepository.login(entity))
          .thenAnswer((_) async => Future<void>.value());

      // When
      expect(loginUsecase.login(user: user, password: password), completes);

      // Then
      verify(() => mockLoginRepository.login(entity)).called(1);
    });

    test('should throw LoginUseCaseException when user or password is empty',
        () async {
      // When & Then
      expect(
        () async => await loginUsecase.login(user: '', password: '140120'),
        throwsA(isA<LoginExceptionUsecase>()),
      );

      expect(
        () async => await loginUsecase.login(user: 'gabriel', password: ''),
        throwsA(isA<LoginExceptionUsecase>()),
      );
    });

    test('should throw LoginUseCaseException when repository throws exception',
        () async {
      // Given
      const user = 'gabriel';
      const password = '140120';
      const entity = User(user: user, password: password);

      when(() => mockLoginRepository.login(entity))
          .thenThrow(LoginExceptionRepository(message: 'Invalid credentials'));

      // When & Then
      expect(
        () async => await loginUsecase.login(user: user, password: password),
        throwsA(isA<LoginExceptionUsecase>()),
      );
    });
  });
}
