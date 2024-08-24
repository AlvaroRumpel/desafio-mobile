import 'custom_exception.dart';

abstract class NetworkException extends CustomException {
  NetworkException({super.message, super.error})
      : super(prefix: 'Network Error: ');
}

class NetworkExceptionService extends NetworkException {
  NetworkExceptionService({super.message, super.error}) : super();
}
