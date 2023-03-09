part of 'connectivity_cubit.dart';

class ConnectivityState extends Equatable {
  const ConnectivityState({
    this.isConnected = false,
  });

  final bool isConnected;

  ConnectivityState copyWith({bool? isConnected}) {
    return ConnectivityState(
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object> get props => [isConnected];
}
