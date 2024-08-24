import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/core/utils/validation.dart';

void main() {
  group('Validation', () {
    test('Required validation should return error message if value is null',
        () {
      // Arrange
      final validation = Required();

      // Act
      final result = validation.validate(null);

      // Assert
      expect(result, equals('Campo obrigatório'));
    });

    test('Required validation should return error message if value is empty',
        () {
      // Arrange
      final validation = Required();

      // Act
      final result = validation.validate('');

      // Assert
      expect(result, equals('Campo obrigatório'));
    });

    test('Required validation should return null if value is not empty', () {
      // Arrange
      final validation = Required();

      // Act
      final result = validation.validate('Some value');

      // Assert
      expect(result, isNull);
    });

    test('Custom validation should use the provided function', () {
      // Arrange
      final validation = Custom(
        validation: (value) {
          if (value == 'test') {
            return null;
          }
          return 'Invalid value';
        },
      );

      // Act
      final resultValid = validation.validate('test');
      final resultInvalid = validation.validate('invalid');

      // Assert
      expect(resultValid, isNull);
      expect(resultInvalid, equals('Invalid value'));
    });

    test('Validate extension should return first validation error if any', () {
      // Arrange
      final validations = [
        Required(),
        Custom(
          validation: (value) =>
              value == 'valid' ? null : 'Invalid custom value',
        ),
      ];

      // Act
      final resultEmpty = validations.validate('');
      final resultInvalid = validations.validate('invalid');
      final resultValid = validations.validate('valid');

      // Assert
      expect(resultEmpty, equals('Campo obrigatório'));
      expect(resultInvalid, equals('Invalid custom value'));
      expect(resultValid, isNull);
    });
  });
}
