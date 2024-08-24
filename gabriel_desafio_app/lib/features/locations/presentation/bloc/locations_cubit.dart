import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/location.dart';
import '../../domain/usecases/locations_usecase.dart';

part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  final LocationsUsecase _usecase;
  LocationsCubit({required LocationsUsecase usecase})
      : _usecase = usecase,
        super(LocationsInitial()) {
    fetchLocationList();
  }

  Future<void> fetchLocationList() async {
    try {
      emit(LocationsLoading());
      final locations = await _usecase.fetchLocationList();
      emit(LocationsSuccess(locations: locations));
    } catch (e) {
      emit(LocationsError(message: e.toString()));
    }
  }
}
