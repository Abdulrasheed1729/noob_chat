part of 'app_bloc.dart';

///
abstract class AppEvent {
  ///
  const AppEvent();
}

/// When the user logs out
class AppLogoutRequested extends AppEvent {
  /// {@macro app_logout_requested}
  const AppLogoutRequested();
}

/// This is when the app state changes
class _AppUserChanged extends AppEvent {
  /// {@macro app_user_changed}
  const _AppUserChanged(this.user);

  final User user;
}
