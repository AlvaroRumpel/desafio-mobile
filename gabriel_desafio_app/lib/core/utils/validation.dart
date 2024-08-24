abstract interface class Validation {
  final String message;

  Validation({required this.message});

  String? validate(String? value);
}

class Required extends Validation {
  Required({super.message = 'Campo obrigatório'});

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return message;
    }

    return null;
  }
}

class Custom extends Validation {
  Custom({
    required this.validation,
  }) : super(message: '');

  String? Function(String?) validation;

  @override
  String? validate(String? value) {
    return validation(value);
  }
}

extension Validate on List<Validation> {
  String? validate(String? value) {
    final errors = <String?>[];
    for (final validation in this) {
      errors.add(validation.validate(value));
    }

    return errors.firstWhere((element) => element != null, orElse: () => null);
  }
}
