import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sss/core/utils/constants/colors.dart';
import 'package:sss/core/utils/constants/sizes.dart';
import 'package:sss/core/utils/constants/image_strings.dart';
import 'package:sss/core/routes/app_routes.dart';

/// Splash screen: shows logo, then navigates to signin after 2 seconds.
/// Flow: splash → signin → signup.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) context.go(AppRoutes.signin);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              MyImages.sssLogo,
              height: 120,
              width: 120,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Text(
                'SSS',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: MyColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: MySizes.xl),
          ],
        ),
      ),
    );
  }
}
