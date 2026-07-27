import 'package:flutter/material.dart';
import 'controllers/app_controller.dart';
import 'core/app_theme.dart';
import 'screens/splash_screen.dart';

class FocusForestApp extends StatelessWidget {
  const FocusForestApp({super.key, required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return AppScope(
          controller: controller,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Focus Forest',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode:
                controller.darkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}

class AppScope extends InheritedNotifier<AppController> {
  const AppScope({
    super.key,
    required AppController controller,
    required super.child,
  }) : super(notifier: controller);

  static AppController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found.');
    return scope!.notifier!;
  }
}
