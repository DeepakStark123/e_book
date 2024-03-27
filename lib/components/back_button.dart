import 'package:e_book/config/app_assest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.backBtnIcon),
          const SizedBox(width: 10),
          Text(
            "Back",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          )
        ],
      ),
    );
  }
}
