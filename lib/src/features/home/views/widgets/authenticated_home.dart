import 'package:indentsystem/src/features/auth/logic/cubit/auth_cubit.dart';
import 'package:indentsystem/src/features/auth/logic/models/user.dart';
import 'package:indentsystem/src/features/notification/views/widgets/notification_handler.dart';
import 'package:indentsystem/src/features/settings/views/screens/settings_screen.dart';
import 'package:indentsystem/src/shared/views/widgets/circles_background.dart';
import 'package:indentsystem/src/shared/views/widgets/underlined_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/logic/models/LoginResponse.dart';

class AuthenticatedHome extends StatelessWidget {
  final UserInfo user;

  AuthenticatedHome({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CirclesBackground(
      backgroundColor: Colors.white,
      topSmallCircleColor: theme.secondaryHeaderColor,
      topMediumCircleColor: theme.primaryColor,
      topRightCircleColor: Colors.white,
      bottomRightCircleColor: theme.highlightColor,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationHandler(),
            const SizedBox(
              height: 80,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: const Text(
                'Authentication Application',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Authenticated as ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  user.email!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.highlightColor,
                    fontSize: 30,
                  ),
                ),
                Text(
                  '(${user.email})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.highlightColor,
                  ),
                ),
                Row(
                  children: [
                    UnderlinedButton(
                      color: theme.secondaryHeaderColor,
                      onPressed: () => context.read<AuthCubit>().logout(),
                      child: const Text('Logout'),
                    ),
                    UnderlinedButton(
                      color: theme.secondaryHeaderColor,
                      onPressed: () => Navigator.pushNamed(
                        context,
                        SettingsScreen.routeName,
                      ),
                      child: const Text('Settings'),
                    )
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                UnderlinedButton(
                  color: theme.highlightColor,
                  onPressed: () => context.read<AuthCubit>().logout(),
                  child: const Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
