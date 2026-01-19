import 'package:course_scheduling/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AuthGradientBtn extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  const AuthGradientBtn({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppPallete.gradient1, AppPallete.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(27),
      ),
      child: ElevatedButton(
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: AppPallete.transparentColor,
        ),
        child: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
      ),
    );
  }
}
