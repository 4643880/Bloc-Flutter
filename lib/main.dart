import 'package:bloc_course/cubits/internet_cubit/internet_cubit.dart';
import 'package:bloc_course/screens/Login/blocs/sign_in_bloc.dart';
import 'package:bloc_course/screens/Login/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Bloc State Management"),
        ),
        body: BlocProvider(
          create: (context) => SignInBloc(),
          child: SignInScreen(),
        ),
      ),
    );
  }
}
