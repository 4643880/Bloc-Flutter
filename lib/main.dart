import 'package:bloc_course/cubits/internet_cubit/internet_cubit.dart';
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
      create: (context) => InternetCubit(),
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
