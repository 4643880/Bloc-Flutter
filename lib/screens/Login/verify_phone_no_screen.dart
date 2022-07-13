import 'package:bloc_course/screens/Login/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_course/screens/Login/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_course/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPhoneNoScreen extends StatelessWidget {
  final TextEditingController _otpController = TextEditingController();

  VerifyPhoneNoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: const Text("Verify Phone Number")),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "6-Digit OTP",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoggedInState) {
                    // It will close all other screens
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CupertinoButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context)
                          .verifyOTP(_otpController.text);
                    },
                    child: const Text("Verify"),
                    color: Colors.blue,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
