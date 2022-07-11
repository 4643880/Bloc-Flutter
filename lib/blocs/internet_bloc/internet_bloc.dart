import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_course/blocs/internet_bloc/internet_event.dart';
import 'package:bloc_course/blocs/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  // Using Connectivity_Plus Package
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription connectivitySubscription;

  // Object of class calling the constructor of the parent class
  InternetBloc() : super(InternetInitialState()) {
    // Emiting the states
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    // Storing in variable I want to dispose it later
    // Adding the events
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
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


