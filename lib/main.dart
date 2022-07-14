import 'package:bloc_course/screens/bloc/counter_bloc.dart';
import 'package:bloc_course/screens/bloc/counter_event.dart';
import 'package:bloc_course/screens/bloc/counter_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() {
    return devtools.log("Firebase Initialized Successfully");
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Bloc State Management"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: BlocConsumer<CounterBloc, CounterState>(
              listener: (context, state) {
                _controller.clear();
              },
              builder: (context, state) {
                final invalidValue =  (state is CounterInvalidState) ? state.invalidValue : "";
                return Column(
                  children: [
                    Text(
                      "Current Value is : ${state.value}",
                      style: const TextStyle(fontSize: 32),
                    ),
                    Visibility(child: Text("Invalid Value is : $invalidValue" ), visible: state is CounterInvalidState,),
                    TextField(
                      controller: _controller,
                      // keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Please Enter a number"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          child: const Icon(Icons.add),
                          onPressed: () {
                            // BlocProvider.of<CounterBloc>(context).add(IncrementEvent());
                            context
                                .read<CounterBloc>()
                                .add(IncrementEvent(value: _controller.text));
                          },
                        ),
                        const SizedBox(height: 8),
                        FloatingActionButton(
                          child: const Icon(Icons.remove),
                          onPressed: () {
                            // BlocProvider.of<CounterBloc>(context).add(IncrementEvent());
                            context
                                .read<CounterBloc>()
                                .add(DecrementEvent(value: _controller.text));
                          },
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}





