import 'custom_exception.dart';

abstract class RegisterNotFoundException extends CustomException {
  RegisterNotFoundException({super.message, super.error})
      : super(prefix: 'Register Not Found: ');
}

class RegisterNotFoundExceptionService extends RegisterNotFoundException {
  RegisterNotFoundExceptionService({super.message, super.error});
}

class RegisterNotFoundExceptionDataSouce extends RegisterNotFoundException {
  RegisterNotFoundExceptionDataSouce({super.message, super.error});
}

class RegisterNotFoundExceptionRepository extends RegisterNotFoundException {
  RegisterNotFoundExceptionRepository({super.message, super.error});
}

class RegisterNotFoundExceptionUsecase extends RegisterNotFoundException {
  RegisterNotFoundExceptionUsecase({super.message, super.error});
}
