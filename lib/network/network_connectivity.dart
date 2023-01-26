import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NetworkConnectivity {
  List<ConnectivityResult> _supportResults = [
    ConnectivityResult.mobile,
    ConnectivityResult.wifi,
  ];

  Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Map<String, VoidCallback> _callback = {};

  NetworkConnectivity() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  void registerConnectivityCallBacks(String key, VoidCallback callback) {
    if (!_callback.containsKey(key)) {
      _callback[key] = callback;
    }
  }

  void unregisterConnectivityCallBacks(String key) {
    if (_callback.containsKey(key)) {
      _callback.remove(key);
    }
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    if (_supportResults.contains(result)) {
      for (final callBack in _callback.values) {
        callBack?.call();
      }
    }
  }

  Future<bool> isOnline() async {
    final result = await _connectivity?.checkConnectivity();

    return result == ConnectivityResult.wifi || result == ConnectivityResult.mobile;
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
