import 'package:get/get.dart';
import 'package:sss/core/routes/app_routes.dart';
import 'package:sss/views/splash_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
  ];
}
