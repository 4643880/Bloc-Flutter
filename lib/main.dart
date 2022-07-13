import 'package:bloc_course/screens/Login/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_course/screens/Login/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_course/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:bloc_course/screens/Login/sign_in_screen.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Bloc State Management"),
          ),
          body: BlocBuilder<AuthCubit, AuthState>(
            // buildWhen: (previous, current) {
            //   return previous is AuthInitialState;
            // },
            builder: (context, state) {              
              // If user is already verified then will go to home directly
              if (state is AuthLoggedInState) {
                return HomeScreen();
              } else if (state is AuthLoggedOutState) {
                return SignInScreen();
              } else {
                return SignInScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
