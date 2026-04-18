import 'package:flutter/material.dart';

class DecoratedScaffold extends StatelessWidget {
  const DecoratedScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    this.gradientColors,
  });

  final Widget child;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry padding;
  final List<Color>? gradientColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                gradientColors ??
                [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(
                    context,
                  ).colorScheme.secondary.withValues(alpha: 0.08),
                ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(padding: padding, child: child),
        ),
      ),
    );
  }
}
