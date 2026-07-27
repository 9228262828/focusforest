import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class TreeIllustration extends StatelessWidget {
  const TreeIllustration({
    super.key,
    this.progress = 1,
    this.size = 190,
    this.treeType = 'Oak',
  });

  final double progress;
  final double size;
  final String treeType;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _TreePainter(
          progress: progress.clamp(0, 1),
          treeType: treeType,
          colorScheme: Theme.of(context).colorScheme,
        ),
      ),
    );
  }
}

class _TreePainter extends CustomPainter {
  _TreePainter({
    required this.progress,
    required this.treeType,
    required this.colorScheme,
  });

  final double progress;
  final String treeType;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * .78);
    final ground = Paint()..color = AppColors.bark.withOpacity(.18);
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * .72,
        height: size.height * .16,
      ),
      ground,
    );

    final trunkHeight = size.height * (.18 + .36 * progress);
    final trunkWidth = size.width * (.055 + .035 * progress);
    final trunk = Paint()
      ..color = AppColors.bark
      ..strokeCap = StrokeCap.round
      ..strokeWidth = trunkWidth;

    canvas.drawLine(
      center.translate(0, -size.height * .03),
      center.translate(0, -trunkHeight),
      trunk,
    );

    final leafPaint = Paint()
      ..color = treeType == 'Golden'
          ? const Color(0xFFF4C542)
          : treeType == 'Cherry'
              ? const Color(0xFFF39AB5)
              : AppColors.leaf;

    final crownCenter = center.translate(0, -trunkHeight);
    final count = math.max(1, (progress * 7).ceil());

    for (var i = 0; i < count; i++) {
      final angle = (i / math.max(1, count)) * math.pi * 2;
      final radius = size.width * (.06 + .13 * progress);
      final offset = Offset(
        math.cos(angle) * radius,
        math.sin(angle) * radius * .65,
      );
      canvas.drawCircle(
        crownCenter + offset,
        size.width * (.045 + .075 * progress),
        leafPaint,
      );
    }

    canvas.drawCircle(
      crownCenter,
      size.width * (.06 + .10 * progress),
      leafPaint,
    );

    if (progress < .12) {
      final seed = Paint()..color = AppColors.bark;
      canvas.drawOval(
        Rect.fromCenter(
          center: center.translate(0, -size.height * .08),
          width: size.width * .11,
          height: size.height * .07,
        ),
        seed,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TreePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.treeType != treeType ||
        oldDelegate.colorScheme != colorScheme;
  }
}
