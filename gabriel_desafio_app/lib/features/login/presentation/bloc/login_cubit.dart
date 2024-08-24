import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required LoginUsecase usecase,
  })  : _usecase = usecase,
        super(LoginInitial());

  final LoginUsecase _usecase;
  Future<void> login({required String user, required String password}) async {
    try {
      emit(LoginLoading());
      await _usecase.login(user: user, password: password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
