import 'package:e_book/controllers/splashCubit/splash_cubit.dart';
import 'package:e_book/config/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplacePage extends StatelessWidget {
  const SplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashCubit splashCubit = BlocProvider.of<SplashCubit>(context);
    // BookController bookController = Get.put(BookController());
    splashCubit.checkUserSession(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              AppColors.ternaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Lottie.asset(AppAssets.animation4),
        ),
      ),
    );
  }
}
