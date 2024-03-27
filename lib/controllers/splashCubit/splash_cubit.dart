import 'package:e_book/presentation/Homepage/home_page.dart';
import 'package:e_book/presentation/WelcomePage/welcome_page.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  final auth = FirebaseAuth.instance;

  void checkUserSession(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        if (auth.currentUser != null) {
          if (context.mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          }
        } else {
          if (context.mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomePage()),
              (route) => false,
            );
          }
        }
      },
    );
  }
}
