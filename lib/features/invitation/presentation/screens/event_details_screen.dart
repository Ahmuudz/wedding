import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/invitation_cubit.dart';
import '../cubit/invitation_state.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/countdown_panel.dart';
import '../widgets/decorated_scaffold.dart';
import '../widgets/info_chip_card.dart';
import '../widgets/wedding_button.dart';
import 'gallery_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  Future<void> _openMap(BuildContext context, InvitationState state) async {
    final event = state.eventDetails;
    final uri = Uri.parse(event.mapsUrl);

    try {
      final canOpen = await canLaunchUrl(uri);
      if (!canOpen) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unable to open Google Maps.')),
          );
        }
        return;
      }

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred while opening the location.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationCubit, InvitationState>(
      builder: (context, state) {
        final event = state.eventDetails;

        return DecoratedScaffold(
          appBar: AppBar(
            title: const Text('Event Details'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedEntrance(
                child: Text(
                  'Join us for an evening of love and celebration',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 18),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 120),
                child: InfoChipCard(
                  icon: Icons.calendar_month_rounded,
                  title: 'Wedding Date',
                  value: event.dateLabel,
                ),
              ),
              const SizedBox(height: 12),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 170),
                child: InfoChipCard(
                  icon: Icons.access_time_filled_rounded,
                  title: 'Wedding Time',
                  value: event.timeLabel,
                ),
              ),
              const SizedBox(height: 12),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 220),
                child: InfoChipCard(
                  icon: Icons.location_on_rounded,
                  title: event.locationName,
                  value: event.locationAddress,
                ),
              ),
              const SizedBox(height: 16),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 250),
                child: WeddingButton(
                  label: 'Open Location in Google Maps',
                  icon: Icons.map_rounded,
                  onPressed: () => _openMap(context, state),
                ),
              ),
              const SizedBox(height: 24),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 300),
                child: Text(
                  'Countdown to "Yes, I Do"',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 12),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 350),
                beginOffset: const Offset(0, 0.16),
                child: CountdownPanel(endDate: event.weddingDateTime),
              ),
              const SizedBox(height: 16),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 390),
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
              const SizedBox(height: 24),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 420),
                child: WeddingButton(
                  label: 'View Couple Gallery',
                  icon: Icons.photo_library_rounded,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const GalleryScreen(),
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
