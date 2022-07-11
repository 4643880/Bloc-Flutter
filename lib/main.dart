import 'package:bloc_course/blocs/internet_bloc/internet_bloc.dart';
import 'package:bloc_course/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetBloc(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Bloc State Management"),
          ),
          body: const HomeScreen(),
        ),
      ),
    );
  }
}
