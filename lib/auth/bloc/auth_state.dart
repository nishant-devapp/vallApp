abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String? idToken;
  final String? refreshToken;
  final String? localId;

  AuthSuccess({this.idToken, this.refreshToken, this.localId});
}


class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
