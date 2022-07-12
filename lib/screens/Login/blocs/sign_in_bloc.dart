import 'package:bloc_course/screens/Login/blocs/sign_in_event.dart';
import 'package:bloc_course/screens/Login/blocs/sign_in_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<TextFieldChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue!) == false) {
        emit(
          SignInErrorState(errorMessage: "Please Enter Correct Email Address"),
        );
      }else if (event.passowrdValue!.length < 8) {
        emit(
          SignInErrorState(
              errorMessage: "Length of Password Should be at least 8"),
        );
      } else {
        emit(SignInValidState());
      }
    });

    on<SignInButtonEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
