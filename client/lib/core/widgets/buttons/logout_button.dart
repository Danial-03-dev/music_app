import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/core/widgets/buttons/custom_icon_button.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/home/repositories/home_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleLogout() async {
      (await ref.read(homeLocalRepositoryProvider.future)).clearLocalAudios();
      ref.read(currentUserProvider.notifier).removeUser();
      ref.read(authLocalRepositoryProvider).removeToken();
    }

    return CustomIconButton(
      onPressed: handleLogout,
      icon: Icons.logout,
      iconSize: 24,
      tooltip: 'logout',
    );
  }
}
