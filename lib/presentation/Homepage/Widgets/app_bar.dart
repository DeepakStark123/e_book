import 'package:e_book/config/app_string.dart';
import 'package:e_book/config/export.dart';
import 'package:e_book/controllers/authCubit/auth_cubit.dart';
import 'package:e_book/presentation/ProfilePage/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthController authController = Get.put(AuthController());
    AuthCubit authCubit = context.read<AuthCubit>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: SvgPicture.asset(AppAssets.dashboardIcon),
        ),
        Text(
          AppString.appName.toUpperCase(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
          child: CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).colorScheme.background,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: authCubit.auth.currentUser == null
                    ? Image.asset(
                        AppAssets.userProfileImage,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        authCubit.auth.currentUser == null
                            ? AppAssets.userProfileImage
                            : "${authCubit.auth.currentUser!.photoURL}",
                        fit: BoxFit.cover,
                      ),
              )),
        )
      ],
    );
  }
}
