import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetState { initial, lost, gained }

class InternetCubit extends Cubit<InternetState> {
  // Using Connectivity_Plus Package
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription connectivitySubscription;

  InternetCubit() : super(InternetState.initial) {
    // Storing in variable I want to dispose it later
    // Adding the events
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetState.gained);
      } else {
        emit(InternetState.lost);
      }
    });
  }

  // Disposing the listner
  @override
  Future<void> close() {
    connectivitySubscription.cancel();
    return super.close();
  }
}
