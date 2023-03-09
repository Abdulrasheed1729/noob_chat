part of 'login_cubit.dart';

///
class LoginState extends Equatable {
  /// {@macro login_state}
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  /// user's email
  final Email email;

  /// user's email
  final Password password;

  /// Form input status
  final FormzStatus status;

  /// authentication error message
  final String? errorMessage;

  /// For updating [LoginState]
  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
