import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/features/login/domain/usecases/login_usecase.dart';
import 'package:gabriel_desafio_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:gabriel_desafio_app/features/login/presentation/page/login_page.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class MockLoginState extends Fake implements LoginState {}

class MockLoginUsecase extends Mock implements LoginUsecase {}

void main() {
  group('Cubit', () {
    late MockLoginUsecase mockLoginUseCase;
    late LoginCubit loginCubit;

    setUp(() {
      mockLoginUseCase = MockLoginUsecase();
      loginCubit = LoginCubit(usecase: mockLoginUseCase);
    });

    tearDown(() {
      loginCubit.close();
    });

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login is successful',
      build: () {
        when(
          () => mockLoginUseCase.login(
            user: any(named: 'user'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Future.value());

        return loginCubit;
      },
      act: (cubit) => cubit.login(user: 'testUser', password: 'testPassword'),
      expect: () => [
        LoginLoading(),
        LoginSuccess(),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginError] when login fails',
      build: () {
        when(
          () => mockLoginUseCase.login(
            user: any(named: 'user'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception('Login failed'));

        return loginCubit;
      },
      act: (cubit) => cubit.login(user: 'testUser', password: 'wrongPassword'),
      expect: () => [
        LoginLoading(),
        const LoginError(message: 'Exception: Login failed'),
      ],
    );
  });

  group('Page', () {
    late MockLoginCubit mockLoginCubit;

    setUp(() {
      registerFallbackValue(MockLoginState());
      mockLoginCubit = MockLoginCubit();
    });

    testWidgets('renders the login form elements', (WidgetTester tester) async {
      // Given
      when(() => mockLoginCubit.state).thenReturn(LoginInitial());

      // When
      await tester.pumpWidget(
        BlocProvider<LoginCubit>.value(
          value: mockLoginCubit,
          child: const MaterialApp(home: LoginPage()),
        ),
      );

      // Then
      expect(
        find.byType(TextFormField),
        findsNWidgets(2),
      ); // Two input fields (username, password)
      expect(find.byType(ElevatedButton), findsOneWidget); // Submit button
    });

    testWidgets('calls login on cubit when form is submitted',
        (WidgetTester tester) async {
      // Given
      when(() => mockLoginCubit.state).thenReturn(LoginInitial());
      when(
        () => mockLoginCubit.login(
          user: 'testUser',
          password: 'testPassword',
        ),
      ).thenAnswer((_) async {});

      // Render the page
      await tester.pumpWidget(
        BlocProvider<LoginCubit>.value(
          value: mockLoginCubit,
          child: const MaterialApp(home: LoginPage()),
        ),
      );

      // Enter text into username and password fields
      await tester.enterText(find.byType(TextFormField).at(0), 'testUser');
      await tester.enterText(find.byType(TextFormField).at(1), 'testPassword');

      // Tap the login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(); // Rebuild the widget after the tap

      // Verify that the login method is called with the correct arguments
      verify(
        () => mockLoginCubit.login(
          user: 'testUser',
          password: 'testPassword',
        ),
      ).called(1);
    });
  });

  group('LoginState', () {
    const String mockErrorMessage = 'An error occurred';

    test('LoginInitial should be a subclass of LoginState', () {
      expect(LoginInitial(), isA<LoginState>());
    });

    test('LoginLoading should be a subclass of LoginState', () {
      expect(LoginLoading(), isA<LoginState>());
    });

    test('LoginSuccess should be a subclass of LoginState', () {
      expect(LoginSuccess(), isA<LoginState>());
    });

    test('LoginError should contain an error message', () {
      const errorState = LoginError(message: mockErrorMessage);
      expect(errorState.message, mockErrorMessage);
    });

    test('LoginError should return the correct props', () {
      const errorState = LoginError(message: mockErrorMessage);
      expect(errorState.props, [mockErrorMessage]);
    });

    group('when method', () {
      test('should execute initial callback when LoginInitial', () {
        final state = LoginInitial();
        final result = state.when(
          initial: () => 'Initial',
          loading: () => 'Loading',
          success: () => 'Success',
          error: (_) => 'Error',
        );
        expect(result, 'Initial');
      });

      test('should execute loading callback when LoginLoading', () {
        final state = LoginLoading();
        final result = state.when(
          initial: () => 'Initial',
          loading: () => 'Loading',
          success: () => 'Success',
          error: (_) => 'Error',
        );
        expect(result, 'Loading');
      });

      test('should execute success callback when LoginSuccess', () {
        final state = LoginSuccess();
        final result = state.when(
          initial: () => 'Initial',
          loading: () => 'Loading',
          success: () => 'Success',
          error: (_) => 'Error',
        );
        expect(result, 'Success');
      });

      test('should execute error callback when LoginError', () {
        const state = LoginError(message: mockErrorMessage);
        final result = state.when(
          initial: () => 'Initial',
          loading: () => 'Loading',
          success: () => 'Success',
          error: (message) => message,
        );
        expect(result, mockErrorMessage);
      });
    });

    group('maybeWhen method', () {
      test('should execute success callback when LoginSuccess', () {
        final state = LoginSuccess();
        final result = state.maybeWhen(
          success: () => 'Success',
          orElse: () => 'orElse',
        );
        expect(result, 'Success');
      });

      test('should execute orElse callback when state is LoginInitial', () {
        final state = LoginInitial();
        final result = state.maybeWhen(
          success: () => 'Success',
          orElse: () => 'orElse',
        );
        expect(result, 'orElse');
      });

      test('should execute error callback when LoginError', () {
        const state = LoginError(message: mockErrorMessage);
        final result = state.maybeWhen(
          error: (message) => message,
          orElse: () => 'orElse',
        );
        expect(result, mockErrorMessage);
      });
    });

    group('whenOrNull method', () {
      test('should execute success callback when LoginSuccess', () {
        final state = LoginSuccess();
        final result = state.whenOrNull(
          success: () => 'Success',
        );
        expect(result, 'Success');
      });

      test('should return null when state is LoginInitial', () {
        final state = LoginInitial();
        final result = state.whenOrNull(
          success: () => 'Success',
        );
        expect(result, isNull);
      });

      test('should return error message when state is LoginError', () {
        const state = LoginError(message: mockErrorMessage);
        final result = state.whenOrNull(
          error: (message) => message,
        );
        expect(result, mockErrorMessage);
      });
    });
  });
}
