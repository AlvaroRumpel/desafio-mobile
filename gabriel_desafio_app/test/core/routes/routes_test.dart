import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/core/routes/routes.dart';
import 'package:gabriel_desafio_app/features/error/presentation/page/error_page.dart';
import 'package:gabriel_desafio_app/features/locations/presentation/page/locations_page.dart';
import 'package:gabriel_desafio_app/features/login/presentation/page/login_page.dart';

void main() {
  group('Routes', () {
    testWidgets('should return LoginPage for LOGIN route',
        (WidgetTester tester) async {
      // Arrange
      const settings = RouteSettings(name: LOGIN);

      // Act
      final route = Routes.generateRoute(settings);

      // Assert
      expect(route, isA<MaterialPageRoute>());
      await tester.pumpWidget(
        const MaterialApp(
          initialRoute: LOGIN,
          onGenerateRoute: Routes.generateRoute,
        ),
      );
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('should return LocationsPage for LOCATIONS route',
        (WidgetTester tester) async {
      // Arrange
      const settings = RouteSettings(name: LOCATIONS);

      // Act
      final route = Routes.generateRoute(settings);

      // Assert
      expect(route, isA<MaterialPageRoute>());
      await tester.pumpWidget(
        const MaterialApp(
          initialRoute: LOCATIONS,
          onGenerateRoute: Routes.generateRoute,
        ),
      );
      expect(find.byType(LocationsPage), findsOneWidget);
    });

    testWidgets(
        'should return ErrorPage for VIDEO_VIEW route with invalid arguments',
        (WidgetTester tester) async {
      // Arrange
      const settings =
          RouteSettings(name: VIDEO_VIEW, arguments: 'Invalid Argument');

      // Act
      final route = Routes.generateRoute(settings);

      // Assert
      expect(route, isA<MaterialPageRoute>());
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: VIDEO_VIEW,
          onGenerateRoute: (_) => Routes.generateRoute(settings),
        ),
      );
      expect(find.byType(ErrorPage), findsOneWidget);
      expect(find.text('Invalid arguments for VIDEO_VIEW'), findsOneWidget);
    });

    testWidgets('should return ErrorPage for unknown route',
        (WidgetTester tester) async {
      // Arrange
      const settings = RouteSettings(name: 'UNKNOWN_ROUTE');

      // Act
      final route = Routes.generateRoute(settings);

      // Assert
      expect(route, isA<MaterialPageRoute>());
      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (_) => Routes.generateRoute(settings),
        ),
      );
      expect(find.byType(ErrorPage), findsOneWidget);
      expect(find.text('Route not found'), findsOneWidget);
    });
  });
}
