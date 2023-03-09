part of 'app_bloc.dart';

///
class AppState extends Equatable {
  /// {@macro app_state}
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  /// State of the app after a user signs in or sign up
  const AppState.authenticated(User user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  /// Initial state of the app before a user is authenticated
  const AppState.unauthenticated()
      : this._(
          status: AppStatus.unauthenticated,
        );

  ///
  final AppStatus status;

  /// current app user
  final User user;

  @override
  List<Object> get props => [status, user];
}

/// app user authentication status
enum AppStatus {
  /// When the user is authenticated
  authenticated,

  /// When the user is not authenticated
  unauthenticated
}
