import 'package:bloc_course/screens/Login/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_course/screens/Login/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_course/screens/Login/verify_phone_no_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Phone Number",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthCodeSentState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerifyPhoneNoScreen()));
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
                    String phoneNumber = "+92" + _phoneController.text;
                    BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                  },
                  child: const Text("Sign In"),
                  color: Colors.blue,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
