import 'package:flutter/material.dart';
import '../app.dart';
import '../widgets/tree_illustration.dart';
import 'shell_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();
  int page = 0;

  final pages = const [
    (
      title: 'Turn focus into growth',
      text: 'Every completed focus session plants a new tree.',
      icon: Icons.eco_rounded,
    ),
    (
      title: 'Stay consistent',
      text: 'Track minutes, streaks, XP, coins, and achievements.',
      icon: Icons.local_fire_department_rounded,
    ),
    (
      title: 'Private by design',
      text: 'No account, no ads, and your progress stays on your device.',
      icon: Icons.lock_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: pages.length,
                  onPageChanged: (value) => setState(() => page = value),
                  itemBuilder: (_, index) {
                    final item = pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (index == 0)
                          const TreeIllustration(size: 220)
                        else
                          Icon(
                            item.icon,
                            size: 110,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        const SizedBox(height: 30),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.text,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.all(4),
                    width: page == index ? 28 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: page == index
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: () async {
                  if (page < pages.length - 1) {
                    await pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                    return;
                  }
                  await AppScope.of(context).completeOnboarding();
                  if (!mounted) return;
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const ShellScreen()),
                  );
                },
                child: Text(page == pages.length - 1 ? 'Start focusing' : 'Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
