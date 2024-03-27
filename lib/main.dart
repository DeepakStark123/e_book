import 'package:e_book/controllers/authCubit/auth_cubit.dart';
import 'package:e_book/controllers/bookCubit/book_cubit.dart';
import 'package:e_book/controllers/splashCubit/splash_cubit.dart';
import 'package:e_book/config/app_theme.dart';
import 'package:e_book/firebase_options.dart';
import 'package:e_book/presentation/SplacePage/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<SplashCubit>(
          create: (BuildContext context) => SplashCubit(),
        ),
        BlocProvider<BookCubit>(
          create: (BuildContext context) => BookCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const SplacePage(),
      ),
    );
  }
}
