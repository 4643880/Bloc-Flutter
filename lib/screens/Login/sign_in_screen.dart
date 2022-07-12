import 'package:bloc_course/screens/Login/blocs/sign_in_bloc.dart';
import 'package:bloc_course/screens/Login/blocs/sign_in_event.dart';
import 'package:bloc_course/screens/Login/blocs/sign_in_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _emailController,
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(TextFieldChangedEvent(
                    emailValue: _emailController.text,
                    passowrdValue: _passwordController.text));
              },
              decoration: const InputDecoration(
                label: Text("Email Address"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(
                  TextFieldChangedEvent(
                      emailValue: _emailController.text,
                      passowrdValue: _passwordController.text),
                );
              },
              decoration: const InputDecoration(
                label: Text("Password"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if(state is SignInLoadingState){
                  return const  Center(child: CircularProgressIndicator());
                }
                return CupertinoButton(
                  onPressed: () {
                    if (state is SignInValidState) {
                      BlocProvider.of<SignInBloc>(context).add(
                        SignInButtonEvent(
                            email: _emailController.text,
                            password: _passwordController.text),
                      );
                    }
                  },
                  child: const Text("Sign In"),
                  color:
                      (state is SignInValidState) ? Colors.blue : Colors.grey,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
