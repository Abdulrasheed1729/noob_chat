part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  /// {@macro login_state}
  const SignUpState({
    this.email = const Email.pure(),
    this.name = const Name.pure(),
    this.password = const Password.pure(),
    this.imageUrl = const ImageUrl.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  /// user's email
  final Email email;

  /// user' name
  final Name name;

  /// user's email
  final Password password;

  /// confirmed password
  final ConfirmedPassword confirmedPassword;

  /// user's display image url
  final ImageUrl imageUrl;

  /// Form input status
  final FormzStatus status;

  /// authentication error message
  final String? errorMessage;

  /// For updating [SignUpState]
  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    Name? name,
    ImageUrl? imageUrl,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        email,
        name,
        password,
        confirmedPassword,
        imageUrl,
        status,
      ];
}
