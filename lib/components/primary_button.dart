import 'package:e_book/config/export.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String btnName;
  final VoidCallback ontap;
  final bool isLoading;
  final String loadingMessage;
  const PrimaryButton(
      {super.key,
      required this.btnName,
      required this.ontap,
      this.isLoading = false,
      this.loadingMessage = "Loading..."});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : ontap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.backgroudColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(AppAssets.googleIcon),
                  ),
            const SizedBox(width: 10),
            Text(
              isLoading ? loadingMessage : btnName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.background,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
