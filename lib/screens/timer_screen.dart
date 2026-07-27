import 'package:flutter/material.dart';
import '../app.dart';
import '../widgets/tree_illustration.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  String _time(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final rest = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$rest';
  }

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);

    return PopScope(
      canPop: !controller.running,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop || !controller.running) return;
        final leave = await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Leave focus session?'),
                content: const Text(
                  'The current tree will stop growing and the session will reset.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Stay'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Leave'),
                  ),
                ],
              ),
            ) ??
            false;

        if (leave && context.mounted) {
          controller.resetTimer();
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Focus session'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              TreeIllustration(
                size: 235,
                progress: controller.progress,
                treeType: controller.selectedTree,
              ),
              const SizedBox(height: 24),
              Text(
                _time(controller.remainingSeconds),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -2,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                controller.running
                    ? controller.paused
                        ? 'Your tree is waiting'
                        : 'Stay focused. Your tree is growing.'
                    : 'Press start when you are ready.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 26),
              LinearProgressIndicator(
                value: controller.progress,
                minHeight: 12,
                borderRadius: BorderRadius.circular(20),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: controller.running || controller.paused
                          ? controller.resetTimer
                          : () => Navigator.pop(context),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: controller.running
                          ? controller.pauseTimer
                          : controller.paused
                              ? controller.resumeTimer
                              : controller.startTimer,
                      icon: Icon(
                        controller.running
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                      label: Text(
                        controller.running
                            ? 'Pause'
                            : controller.paused
                                ? 'Resume'
                                : 'Start',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  await controller.finishEarlyForTesting();
                  if (!context.mounted) return;
                  await showDialog<void>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Tree planted!'),
                      content: Text(
                        'You earned ${controller.selectedMinutes} XP and '
                        '${(controller.selectedMinutes / 5).ceil()} coins.',
                      ),
                      actions: [
                        FilledButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Great'),
                        ),
                      ],
                    ),
                  );
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Complete session now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
