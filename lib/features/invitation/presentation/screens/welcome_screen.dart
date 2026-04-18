import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/invitation_cubit.dart';
import '../cubit/invitation_state.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/wedding_button.dart';
import 'event_details_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  bool _isNetworkImage(String value) {
    return value.startsWith('http://') || value.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationCubit, InvitationState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              _isNetworkImage(state.heroImage)
                  ? Image.network(
                      state.heroImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.35),
                                Theme.of(
                                  context,
                                ).colorScheme.secondary.withValues(alpha: 0.32),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Image.asset(
                      state.heroImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.35),
                                Theme.of(
                                  context,
                                ).colorScheme.secondary.withValues(alpha: 0.32),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x33000000), Color(0x92000000)],
                  ),
                ),
              ),
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final height = constraints.maxHeight;
                    final horizontalPadding = (width * 0.06)
                        .clamp(16.0, 28.0)
                        .toDouble();
                    final verticalPadding = (height * 0.035)
                        .clamp(14.0, 28.0)
                        .toDouble();
                    final titleFontSize = (width * 0.095)
                        .clamp(28.0, 42.0)
                        .toDouble();
                    final gap = (height * 0.03).clamp(16.0, 24.0).toDouble();

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          AnimatedEntrance(
                            delay: const Duration(milliseconds: 120),
                            child: Text(
                              'You are invited to celebrate\nthe wedding of\nAhmed & Anan',
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(
                                    fontSize: titleFontSize,
                                    color: Colors.white,
                                    height: 1.2,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          SizedBox(height: gap),
                          AnimatedEntrance(
                            delay: const Duration(milliseconds: 260),
                            beginOffset: const Offset(0, 0.2),
                            child: WeddingButton(
                              label: 'View Invitation',
                              icon: Icons.auto_awesome_rounded,
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder<void>(
                                    transitionDuration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    pageBuilder: (_, animation, __) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: const EventDetailsScreen(),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
