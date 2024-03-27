import 'package:e_book/controllers/authCubit/auth_cubit.dart';
import 'package:e_book/presentation/Homepage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:e_book/config/export.dart';
import 'package:e_book/components/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CustomShapeClipper(),
              child: Container(
                height: height * 0.65,
                padding: const EdgeInsets.all(20),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      AppAssets.bookImage,
                      width: height * 0.35,
                    ),
                    SizedBox(height: height * 0.07),
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(seconds: 3),
                      child: Text(
                        "Explore Your Favorite Books",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Flexible(
                      child: Text(
                        "Discover, read, and listen to the world's best books with just a few taps.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: height * 0.03),
                  Text(
                    "Disclaimer",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    "The content provided is for demonstration purposes only. Actual book selections and services may vary.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (BuildContext context, AuthState state) {
                if (state is AuthErrorState) {
                  errorMessage(state.errorMsg);
                } else if (state is AuthSuccessState) {
                  successMessage(state.successMsg);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                }
              },
              builder: (BuildContext context, AuthState state) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: PrimaryButton(
                    loadingMessage: "Signing....",
                    isLoading: (state is AuthLoadingState) ? true : false,
                    btnName: "LOGIN WITH GOOGLE",
                    ontap: () {
                      authCubit.loginWithEmail();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
