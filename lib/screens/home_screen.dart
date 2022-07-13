import 'package:bloc_course/screens/Login/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_course/screens/Login/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_course/screens/Login/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final a = FirebaseAuth.instance.currentUser;
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Welcome",
                  style: TextStyle(fontSize: 40),
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if(state is AuthLoggedOutState){
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                  }
            
                },
                builder: (context, state) {
                  return CupertinoButton(
                    color: Colors.blue,
                      child: const Text("Log Out"), onPressed: () {
                        BlocProvider.of<AuthCubit>(context).logOut();
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
