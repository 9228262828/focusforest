import 'package:flutter/material.dart';
import '../app.dart';
import '../widgets/stat_card.dart';
import '../widgets/tree_illustration.dart';
import 'timer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Forest'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Chip(
              avatar: const Icon(Icons.monetization_on_rounded, size: 18),
              label: Text('${controller.coins}'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  TreeIllustration(
                    size: 185,
                    treeType: controller.selectedTree,
                  ),
                  Text(
                    'Ready to grow?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Choose a session and plant a ${controller.selectedTree} tree.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 22),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [15, 25, 45].map((minutes) {
                      return ChoiceChip(
                        label: Text('$minutes min'),
                        selected: controller.selectedMinutes == minutes,
                        onSelected: (_) => controller.setDuration(minutes),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: Text('Start ${controller.selectedMinutes} min'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TimerScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              StatCard(
                icon: Icons.bolt_rounded,
                value: '${controller.todayMinutes}',
                label: 'Today min',
              ),
              StatCard(
                icon: Icons.local_fire_department_rounded,
                value: '${controller.streak}',
                label: 'Day streak',
              ),
              StatCard(
                icon: Icons.stars_rounded,
                value: '${controller.level}',
                label: 'Level',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
