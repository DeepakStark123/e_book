import 'package:e_book/config/app_utility.dart';
import 'package:e_book/presentation/WelcomePage/welcome_page.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final auth = FirebaseAuth.instance;

  void loginWithEmail() async {
    emit(AuthLoadingState());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(const AuthErrorState(errorMsg: 'Google Sign-In Failed'));
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      try {
        await auth.signInWithCredential(credential).then((value) {
          emit(const AuthSuccessState(successMsg: 'Login Successful'));
        }).onError((error, stackTrace) {
          emit(AuthErrorState(errorMsg: error.toString()));
        });
      } catch (e) {
        emit(AuthErrorState(errorMsg: e.toString()));
      }
    } catch (error) {
      emit(AuthErrorState(errorMsg: error.toString()));
    }
  }

  void signout(BuildContext context) async {
    await auth.signOut();
    successMessage('Logout Successful');
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const WelcomePage()),
        (route) => false,
      );
    }
  }
}
