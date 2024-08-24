import 'custom_exception.dart';

abstract class UnauthorizedException extends CustomException {
  UnauthorizedException({super.message, super.error})
      : super(prefix: 'Unauthorized: ');
}

class UnauthorizedExceptionService extends UnauthorizedException {
  UnauthorizedExceptionService({super.message, super.error});
}
