
abstract class CounterEvent {
  final String value;

  CounterEvent({required this.value});
}


class IncrementEvent extends CounterEvent {

  IncrementEvent({required String value}) : super(value: value);
}

class DecrementEvent extends CounterEvent {

  DecrementEvent({required String value}) : super(value: value);
}
