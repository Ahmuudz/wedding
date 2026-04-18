import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/rsvp_status.dart';
import '../cubit/invitation_cubit.dart';
import '../cubit/invitation_state.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/decorated_scaffold.dart';
import '../widgets/wedding_button.dart';
import 'rsvp_result_screen.dart';

class RsvpScreen extends StatelessWidget {
  const RsvpScreen({super.key});

  Future<void> _handleRsvpSelection(
    BuildContext context,
    RsvpStatus status,
  ) async {
    final cubit = context.read<InvitationCubit>();
    await cubit.submitRsvp(status);

    if (!context.mounted) {
      return;
    }

    final hasError = cubit.state.errorMessage != null;
    if (hasError) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => RsvpResultScreen(status: status)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvitationCubit, InvitationState>(
      listenWhen: (previous, current) =>
          previous.snackBarMessage != current.snackBarMessage &&
          current.snackBarMessage != null,
      listener: (context, state) {
        final message = state.snackBarMessage;
        if (message == null) {
          return;
        }

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));

        context.read<InvitationCubit>().clearSnackBarMessage();
      },
      child: BlocBuilder<InvitationCubit, InvitationState>(
        builder: (context, state) {
          return DecoratedScaffold(
            appBar: AppBar(
              title: const Text('RSVP'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedEntrance(
                  child: Text(
                    'Will you be joining us on our special day?',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedEntrance(
                  delay: const Duration(milliseconds: 80),
                  child: Text(
                    'Your response helps us prepare the celebration with care.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedEntrance(
                  delay: const Duration(milliseconds: 170),
                  child: WeddingButton(
                    label: 'I will attend',
                    icon: Icons.favorite,
                    isLoading: state.isSaving,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: state.rsvpStatus == RsvpStatus.attending
                        ? null
                        : () async {
                            await _handleRsvpSelection(
                              context,
                              RsvpStatus.attending,
                            );
                          },
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedEntrance(
                  delay: const Duration(milliseconds: 230),
                  child: WeddingButton(
                    label: "Sorry, I can't attend",
                    icon: Icons.sentiment_dissatisfied_rounded,
                    isLoading: state.isSaving,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.9),
                    onPressed: state.rsvpStatus == RsvpStatus.notAttending
                        ? null
                        : () async {
                            await _handleRsvpSelection(
                              context,
                              RsvpStatus.notAttending,
                            );
                          },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
