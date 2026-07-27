import 'package:flutter/material.dart';
import '../app.dart';
import '../widgets/stat_card.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final targetXp = controller.level * 100;
    final levelProgress = (controller.xp % 100) / 100;

    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              StatCard(
                icon: Icons.schedule_rounded,
                value: '${controller.totalMinutes}',
                label: 'Total min',
              ),
              StatCard(
                icon: Icons.park_rounded,
                value: '${controller.sessions.length}',
                label: 'Trees',
              ),
            ],
          ),
          Row(
            children: [
              StatCard(
                icon: Icons.local_fire_department_rounded,
                value: '${controller.streak}',
                label: 'Streak',
              ),
              StatCard(
                icon: Icons.bolt_rounded,
                value: '${controller.xp}',
                label: 'Total XP',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Level ${controller.level}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text('${controller.xp} / $targetXp XP'),
                  const SizedBox(height: 14),
                  LinearProgressIndicator(
                    value: levelProgress,
                    minHeight: 12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Achievements',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 10),
          _Achievement(
            title: 'First Seed',
            subtitle: 'Complete your first focus session',
            unlocked: controller.sessions.isNotEmpty,
          ),
          _Achievement(
            title: 'Small Grove',
            subtitle: 'Plant 5 trees',
            unlocked: controller.sessions.length >= 5,
          ),
          _Achievement(
            title: 'Focused Mind',
            subtitle: 'Reach 300 total focus minutes',
            unlocked: controller.totalMinutes >= 300,
          ),
          _Achievement(
            title: 'Forest Keeper',
            subtitle: 'Maintain a 7-day streak',
            unlocked: controller.streak >= 7,
          ),
        ],
      ),
    );
  }
}

class _Achievement extends StatelessWidget {
  const _Achievement({
    required this.title,
    required this.subtitle,
    required this.unlocked,
  });

  final String title;
  final String subtitle;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(unlocked ? Icons.emoji_events : Icons.lock_outline),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(
          unlocked ? Icons.check_circle : Icons.circle_outlined,
          color: unlocked ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
    );
  }
}
