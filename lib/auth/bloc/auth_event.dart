abstract class AuthEvent {}

class SignupUserEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignupUserEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;

  LoginUserEvent({
    required this.email,
    required this.password,
  });
}

