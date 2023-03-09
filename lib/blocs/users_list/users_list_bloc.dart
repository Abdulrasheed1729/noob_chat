import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:noob_chat/repositories/repositories.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  UsersListBloc(this._userRepository) : super(const UsersListState()) {
    on<UsersListEvent>(_onUsersListSubscriptionRequested);
  }

  final UserRepository _userRepository;

  FutureOr<void> _onUsersListSubscriptionRequested(
    UsersListEvent event,
    Emitter<UsersListState> emit,
  ) async {
    emit(state.copyWith(status: () => UsersListStatus.loading));

    await emit.forEach(
      _userRepository.users,
      onData: (users) => state.copyWith(
        status: () => UsersListStatus.success,
        users: () => users,
      ),
      onError: (_, __) => state.copyWith(
        status: () => UsersListStatus.failure,
      ),
    );
  }
}
