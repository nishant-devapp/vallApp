import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignupUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final localId = await authRepository.signUpUser(
            event.name, event.email, event.password);

        if(localId.isNotEmpty){
          await authRepository.addUserData(
            event.name,
            event.email,
            localId,
          );
        }

        emit(AuthSuccess(localId: localId));

      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });


    on<LoginUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await authRepository.loginUser(
          event.email,
          event.password,
        );

        final idToken = response.idToken;
        final refreshToken = response.refreshToken;
        final localId = response.localId;

        // Storing token in shared preference
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('idToken', idToken!);
        await prefs.setString('refreshToken', refreshToken!);
        await prefs.setString('localId', localId!);

        emit(AuthSuccess(idToken: idToken, refreshToken: refreshToken));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

  }



}
