import 'package:bloc_course/screens/Login/cubits/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitialState()) {
    // If user is already verified then will go to home directly
    final myuser = _auth.currentUser;
    if (myuser != null) {
      emit(AuthLoggedInState(firebaseUser: myuser));
    } else {
      emit(AuthLoggedOutState());
    }
  }

  String? _verificationId;
  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(AuthErrorState(errorMessage: e.message.toString()));
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        emit(AuthCodeSentState());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    emit(AuthLoadingState());

    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      // Sign the user in (or link) with the credential
      signInWithPhone(credential);
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(errorMessage: e.message.toString()));
    }
  }

  void signInWithPhone(PhoneAuthCredential phoneAuthCredential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(firebaseUser: userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(errorMessage: e.message.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
