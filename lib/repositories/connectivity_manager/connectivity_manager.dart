import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityManager {
  final connectivity = Connectivity();

  Stream<ConnectivityResult> get connectivityStateChanges {
    return connectivity.onConnectivityChanged.map(
      (connectivityResult) {
        if (connectivityResult == ConnectivityResult.mobile) {
          return ConnectivityResult.mobile;
        } else if (connectivityResult == ConnectivityResult.wifi) {
          return ConnectivityResult.wifi;
        } else {
          return ConnectivityResult.none;
        }
      },
    );
  }
}
