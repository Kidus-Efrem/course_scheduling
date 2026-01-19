import 'package:course_scheduling/features/auth/domain/usecases/user_sign_in.dart';
import 'package:course_scheduling/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  AuthBloc({required UserSignUp userSignUp, required UserSignIn userSignIn})
    : _userSignUp = userSignUp,
      _userSignIn = userSignIn,

      super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final res = await _userSignUp(
        UserSignUpParams(
          email: event.email,
          name: event.name,
          password: event.password,
        ),
      );
      res.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSuccess(uid: r)),
      );
    });
    on<AuthSignIn>((event, emit) async {
      final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password),
      );
      res.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) {
          debugPrint("user signed in successful! UID: $r");
          emit(AuthSuccess(uid: r));},
      );
    });
  }
}
