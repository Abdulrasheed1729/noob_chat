part of 'users_list_bloc.dart';

abstract class UsersListEvent extends Equatable {
  const UsersListEvent();

  @override
  List<Object> get props => [];
}

class UsersListSubscriptionRequested extends UsersListEvent {
  const UsersListSubscriptionRequested();
}
