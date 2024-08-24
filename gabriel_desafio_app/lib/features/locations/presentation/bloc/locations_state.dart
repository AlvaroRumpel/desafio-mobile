part of 'locations_cubit.dart';

@immutable
sealed class LocationsState extends Equatable {
  const LocationsState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<Location> locations) success,
    required T Function(String message) error,
  }) {
    if (this is LocationsInitial) {
      return initial();
    } else if (this is LocationsLoading) {
      return loading();
    } else if (this is LocationsSuccess) {
      return success((this as LocationsSuccess).locations);
    } else if (this is LocationsError) {
      return error((this as LocationsError).message);
    }
    throw Exception('Unreachable');
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<Location> locations)? success,
    T Function(String message)? error,
    required T Function() orElse,
  }) {
    if (this is LocationsInitial && initial != null) {
      return initial();
    } else if (this is LocationsLoading && loading != null) {
      return loading();
    } else if (this is LocationsSuccess && success != null) {
      return success((this as LocationsSuccess).locations);
    } else if (this is LocationsError && error != null) {
      return error((this as LocationsError).message);
    } else {
      return orElse();
    }
  }

  T? whenOrNull<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<Location> locations)? success,
    T Function(String message)? error,
  }) {
    return maybeWhen(
      initial: initial,
      loading: loading,
      success: success,
      error: error,
      orElse: () => null,
    );
  }

  @override
  List<Object?> get props => [];
}

final class LocationsInitial extends LocationsState {}

final class LocationsLoading extends LocationsState {}

final class LocationsSuccess extends LocationsState {
  final List<Location> locations;

  const LocationsSuccess({required this.locations});

  @override
  List<Object?> get props => [locations];
}

final class LocationsError extends LocationsState {
  final String message;

  const LocationsError({required this.message});

  @override
  List<Object?> get props => [message];
}
