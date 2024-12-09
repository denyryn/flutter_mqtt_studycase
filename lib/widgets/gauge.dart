import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class Gauge extends StatelessWidget {
  final String label;
  final RxDouble value;
  final double min;
  final double max;

  const Gauge({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: SizedBox(
          width: 200, // Adjust this value as needed
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure it wraps content
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: context.textTheme.bodyLarge!.fontSize,
                  fontWeight: context.textTheme.bodyLarge!.fontWeight,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedRadialGauge(
                duration: const Duration(seconds: 1),
                curve: Curves.easeOutQuad,
                radius: 100,
                axis: GaugeAxis(
                  min: min,
                  max: max,
                  degrees: 270,
                  style: const GaugeAxisStyle(
                    thickness: 30,
                    background: Colors.transparent,
                    segmentSpacing: 2,
                    blendColors: true,
                    cornerRadius: Radius.circular(80),
                  ),
                  progressBar: const GaugeProgressBar.rounded(
                    color: Colors.transparent,
                  ),
                  segments: [
                    GaugeSegment(
                      from: min,
                      to: max / 3,
                      color: Colors.blue[300]!,
                      cornerRadius: const Radius.circular(8),
                    ),
                    GaugeSegment(
                      from: max / 3 + 1,
                      to: (max / 3) * 2,
                      color: Colors.yellow[300]!,
                      cornerRadius: const Radius.circular(8),
                    ),
                    GaugeSegment(
                      from: (max / 3) * 2 + 1,
                      to: max,
                      color: Colors.red[300]!,
                      cornerRadius: const Radius.circular(8),
                    ),
                  ],
                ),
                value: value.value,
                builder: (context, child, value) => RadialGaugeLabel(
                  value: value,
                  style: TextStyle(
                    color: context.textTheme.headlineSmall!.color,
                    fontSize: context.textTheme.headlineSmall!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('°C'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
