import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CountdownPanel extends StatelessWidget {
  const CountdownPanel({super.key, required this.endDate});

  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    final endTime = endDate.millisecondsSinceEpoch;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final spacing = maxWidth < 360 ? 8.0 : 10.0;
        final columns = maxWidth < 340 ? 2 : 4;
        final horizontalGaps = spacing * (columns - 1);
        final cardWidth = ((maxWidth - horizontalGaps) / columns)
            .clamp(68.0, 92.0)
            .toDouble();
        final panelPadding = maxWidth < 360 ? 16.0 : 20.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(panelPadding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.14),
                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.14),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: CountdownTimer(
            endTime: endTime,
            widgetBuilder: (_, time) {
              if (time == null) {
                return Center(
                  child: Text(
                    'The wedding celebration has started!',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                alignment: WrapAlignment.center,
                children: [
                  _TimeCard(
                    label: 'Days',
                    value: (time.days ?? 0).toString(),
                    width: cardWidth,
                  ),
                  _TimeCard(
                    label: 'Hours',
                    value: (time.hours ?? 0).toString(),
                    width: cardWidth,
                  ),
                  _TimeCard(
                    label: 'Minutes',
                    value: (time.min ?? 0).toString(),
                    width: cardWidth,
                  ),
                  _TimeCard(
                    label: 'Seconds',
                    value: (time.sec ?? 0).toString(),
                    width: cardWidth,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _TimeCard extends StatelessWidget {
  const _TimeCard({
    required this.label,
    required this.value,
    required this.width,
  });

  final String label;
  final String value;
  final double width;

  @override
  Widget build(BuildContext context) {
    final verticalPadding = width < 76 ? 8.0 : 10.0;
    final numberFontSize = width < 76 ? 22.0 : 24.0;

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value.padLeft(2, '0'),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: numberFontSize,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
