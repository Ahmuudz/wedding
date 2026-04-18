import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/invitation/data/datasources/local_invitation_data_source.dart';
import 'features/invitation/data/datasources/remote_invitation_data_source.dart';
import 'features/invitation/data/repositories/invitation_repository_impl.dart';
import 'features/invitation/domain/usecases/get_invitation_content.dart';
import 'features/invitation/domain/usecases/get_rsvp_summary.dart';
import 'features/invitation/domain/usecases/get_saved_rsvp.dart';
import 'features/invitation/domain/usecases/save_rsvp.dart';
import 'features/invitation/presentation/cubit/invitation_cubit.dart';
import 'features/invitation/presentation/screens/welcome_screen.dart';

class WeddingInvitationApp extends StatelessWidget {
  const WeddingInvitationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = InvitationRepositoryImpl(
      localDataSource: LocalInvitationDataSourceImpl(),
      remoteDataSource: const RemoteInvitationDataSource(),
    );

    return BlocProvider(
      create: (_) => InvitationCubit(
        getInvitationContent: GetInvitationContent(repository),
        getSavedRsvp: GetSavedRsvp(repository),
        getRsvpSummary: GetRsvpSummary(repository),
        saveRsvp: SaveRsvp(repository),
      )..loadSavedRsvp(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wedding Invitation App',
        theme: AppTheme.lightTheme,
        home: const WelcomeScreen(),
      ),
    );
  }
}
