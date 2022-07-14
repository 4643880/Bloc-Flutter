import 'package:bloc_course/screens/bloc/counter_event.dart';
import 'package:bloc_course/screens/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterValidState(validValue: 0)) {
    on<IncrementEvent>((event, emit) {
      
      final myInteger = int.tryParse(event.value);

      if (myInteger == null) {
        emit(CounterInvalidState(
          invalidValue: event.value,
          previousValue: state.value,
        ));
      } else {
        emit(CounterValidState(validValue: state.value + myInteger));
      }
    });

    on<DecrementEvent>((event, emit) {
      final myInteger = int.tryParse(event.value);
      if (myInteger == null) {
        emit(CounterInvalidState(
          invalidValue: event.value,
          previousValue: state.value,
        ));
      } else {
        emit(CounterValidState(validValue: state.value - myInteger));
      }
    });
  }
}
