import 'package:flutter/cupertino.dart';

@immutable
abstract class CounterState {
  final int value;

  const CounterState({required this.value});
}

class CounterValidState extends CounterState {

  const CounterValidState({required validValue}) : super(value: validValue);
}

class CounterInvalidState extends CounterState {
  final String invalidValue;

  const CounterInvalidState({
    required this.invalidValue,
    required int previousValue,
  }) : super(value: previousValue);
}
