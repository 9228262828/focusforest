import 'dart:async';
import 'package:flutter/material.dart';
import '../app.dart';
import '../widgets/tree_illustration.dart';
import 'onboarding_screen.dart';
import 'shell_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      final controller = AppScope.of(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => controller.onboardingDone
              ? const ShellScreen()
              : const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: .75, end: 1),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutBack,
          builder: (_, value, child) =>
              Transform.scale(scale: value, child: child),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TreeIllustration(size: 190),
              const SizedBox(height: 10),
              Text(
                'Focus Forest',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const Text('Focus more. Grow your forest.'),
            ],
          ),
        ),
      ),
    );
  }
}
