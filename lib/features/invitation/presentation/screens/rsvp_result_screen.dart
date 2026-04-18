import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/rsvp_status.dart';
import '../cubit/invitation_cubit.dart';
import '../cubit/invitation_state.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/decorated_scaffold.dart';
import '../widgets/wedding_button.dart';

class RsvpResultScreen extends StatelessWidget {
  const RsvpResultScreen({super.key, required this.status});

  final RsvpStatus status;

  @override
  Widget build(BuildContext context) {
    final isAttending = status == RsvpStatus.attending;

    return DecoratedScaffold(
      appBar: AppBar(
        title: const Text('Your RSVP'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      child: BlocBuilder<InvitationCubit, InvitationState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedEntrance(
                child: Icon(
                  isAttending
                      ? Icons.celebration_rounded
                      : Icons.favorite_outline,
                  size: 56,
                  color: isAttending
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 16),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 80),
                child: Text(
                  isAttending
                      ? 'Thank you, Ahmed & Anan cannot wait to celebrate with you!'
                      : 'Thank you for your response. You will be missed on our special day.',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 12),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 140),
                child: Text(
                  'Your RSVP has been saved successfully.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 24),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 180),
                child: Row(
                  children: [
                    Expanded(
                      child: _CounterCard(
                        title: 'Coming',
                        value: state.attendingCount,
                        icon: Icons.favorite,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _CounterCard(
                        title: 'Not coming',
                        value: state.notAttendingCount,
                        icon: Icons.block,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 220),
                child: WeddingButton(
                  label: 'Back to Invitation',
                  icon: Icons.arrow_back_rounded,
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CounterCard extends StatelessWidget {
  const _CounterCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final int value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
