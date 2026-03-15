import 'dart:ui' as ui;

import 'package:sss/core/routes/app_router.dart';
import 'package:sss/core/utils/constants/colors.dart';
import 'package:sss/core/utils/theme/theme.dart';
import 'package:sss/core/database/isar_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'firebase_options.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showAppSnackbar({
  required String title,
  required String message,
  required Color backgroundColor,
}) {
  final messenger = rootScaffoldMessengerKey.currentState;
  if (messenger == null) return;
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      content: Text(
        '$title: $message',
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
    ),
  );
}

Future<void> main() async {
  final logger = Logger();
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase (Auth + Firestore + Storage)
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
    if (kDebugMode) {
      logger.d("Firebase initialized");
    }
    // Crashlytics: aim for ≥99.7% crash-free sessions (not supported on web)
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };
    ui.PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  // Local DB (Isar) – not supported on web
  await IsarStorage.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'SSS',
      theme: MyAppTheme.lightTheme.copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: MyColors.primary,
          selectionColor: Color(0x40369EFF),
          selectionHandleColor: MyColors.primary,
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
