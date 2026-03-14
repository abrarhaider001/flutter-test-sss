import 'package:flutter/material.dart';
import 'package:sss/core/utils/constants/colors.dart';

/// Simple splash screen shown at app launch.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SSS',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: MyColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
