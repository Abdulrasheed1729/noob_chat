import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:noob_chat/repositories/repositories.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit(this._connectivityManager)
      : super(const ConnectivityState()) {
    _connectivitySubscription = _connectivityManager.connectivityStateChanges
        .listen(_listenToConnectivity);
  }

  void _listenToConnectivity(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      emit(state.copyWith(isConnected: true));
    } else {
      emit(state.copyWith(isConnected: false));
    }
  }

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final ConnectivityManager _connectivityManager;

  @override
  Future<void> close() async {
    await _connectivitySubscription.cancel();
    await super.close();
  }
}
