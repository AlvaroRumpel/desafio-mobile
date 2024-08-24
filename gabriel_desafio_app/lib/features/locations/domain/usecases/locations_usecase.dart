import '../../../../core/exceptions/exception.dart';
import '../entities/location.dart';
import '../repositories/locations_repository.dart';

class LocationsUsecase {
  final LocationsRepository _repository;

  LocationsUsecase({required LocationsRepository repository})
      : _repository = repository;

  Future<List<Location>> fetchLocationList() async {
    try {
      final result = await _repository.fetchLocationList();
      return result;
    } on RegisterNotFoundException {
      throw RegisterNotFoundExceptionUsecase(
        message: 'Nenhum local foi encontrado, tente novamente mais tarde',
      );
    } catch (e) {
      throw CustomException(
        message: 'Erro ao buscar a lista de locais, por favor tente novamente',
        error: e,
      );
    }
  }
}
