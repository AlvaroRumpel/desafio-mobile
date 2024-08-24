import 'custom_exception.dart';

abstract class InvalidInputException extends CustomException {
  InvalidInputException({super.message, super.error})
      : super(prefix: 'Invalid Input: ');
}

class InvalidInputExceptionService extends InvalidInputException {
  InvalidInputExceptionService({super.message, super.error}) : super();
}
