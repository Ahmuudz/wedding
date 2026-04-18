import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/invitation_cubit.dart';
import '../cubit/invitation_state.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/decorated_scaffold.dart';
import '../widgets/wedding_button.dart';
import 'rsvp_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationCubit, InvitationState>(
      builder: (context, state) {
        return DecoratedScaffold(
          gradientColors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.16),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.26),
          ],
          appBar: AppBar(
            title: const Text('Our Story in Pictures'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedEntrance(
                child: Text(
                  'A few moments we cherish forever',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 16),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 130),
                child: CarouselSlider.builder(
                  itemCount: state.galleryImages.length,
                  itemBuilder: (context, index, __) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        image: DecorationImage(
                          image: AssetImage(state.galleryImages[index]),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.84,
                    aspectRatio: 0.82,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 220),
                child: WeddingButton(
                  label: 'RSVP Now',
                  icon: Icons.mark_email_read_rounded,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const RsvpScreen(),
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
