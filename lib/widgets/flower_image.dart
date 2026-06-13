import 'package:flutter/material.dart';
import '../models/city_flower.dart';
import '../theme/flower_theme.dart';

class FlowerImage extends StatelessWidget {
  final CityFlower flower;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  const FlowerImage({
    super.key,
    required this.flower,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.zero;
    return ClipRRect(
      borderRadius: radius,
      child: Image.asset(
        flower.imageAsset,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (ctx, e, st) => _Placeholder(flower: flower, width: width, height: height),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final CityFlower flower;
  final double? width;
  final double? height;

  const _Placeholder({required this.flower, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            flower.accentColor.withValues(alpha: 0.15),
            flower.accentColor.withValues(alpha: 0.30),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(flower.emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 6),
            Text(
              flower.flowerName,
              style: FlowerTheme.serif(
                fontSize: 13,
                color: flower.accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
