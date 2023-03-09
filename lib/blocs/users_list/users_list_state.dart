part of 'users_list_bloc.dart';

class UsersListState extends Equatable {
  const UsersListState({
    this.status = UsersListStatus.initial,
    this.users = const [],
  });

  final UsersListStatus status;
  final List<types.User> users;

  UsersListState copyWith({
    List<types.User> Function()? users,
    UsersListStatus Function()? status,
  }) {
    return UsersListState(
      status: status != null ? status() : this.status,
      users: users != null ? users() : this.users,
    );
  }

  @override
  List<Object> get props => [status, users];
}

enum UsersListStatus {
  initial,
  loading,
  success,
  failure,
}
