import 'package:flutter/material.dart';
import '../app.dart';
import '../widgets/tree_illustration.dart';

class ForestScreen extends StatelessWidget {
  const ForestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Forest'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Chip(label: Text('${controller.sessions.length} trees')),
          ),
        ],
      ),
      body: controller.sessions.isEmpty
          ? const _EmptyForest()
          : GridView.builder(
              padding: const EdgeInsets.all(18),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .82,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: controller.sessions.length,
              itemBuilder: (_, index) {
                final session = controller.sessions[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Expanded(
                          child: TreeIllustration(
                            size: 140,
                            treeType: session.treeType,
                          ),
                        ),
                        Text(
                          session.treeType,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        Text('${session.minutes} min'),
                        Text(
                          '${session.completedAt.day}/${session.completedAt.month}/${session.completedAt.year}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _EmptyForest extends StatelessWidget {
  const _EmptyForest();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.park_outlined,
              size: 90,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'Your forest is waiting',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Complete your first focus session to plant a tree.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
