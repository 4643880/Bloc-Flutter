abstract class SignInEvent {}

class TextFieldChangedEvent extends SignInEvent {
  final String? emailValue;
  final String? passowrdValue;

  TextFieldChangedEvent({
    this.emailValue,
    this.passowrdValue,
  });
}

class SignInButtonEvent extends SignInEvent {
  final String email;
  final String password;

  SignInButtonEvent({required this.email, required this.password});
}
