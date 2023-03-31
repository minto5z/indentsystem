import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indentsystem/src/features/auth/logic/cubit/auth_cubit.dart';
import 'package:indentsystem/src/features/settings/views/screens/settings_screen.dart';
import 'package:indentsystem/src/shared/views/widgets/underlined_button.dart';
import 'package:provider/provider.dart';

import '../../../auth/logic/models/login_response.dart';

class AuthenticatedHome extends StatelessWidget {
  final UserInfo user;

  AuthenticatedHome({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          color: Colors.black87,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SvgPicture.asset("assets/icons/Location.svg"),
            //const SizedBox(width: defaultPadding / 2),
            Text(
              "Indent System",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/icons/Notification.svg"),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  color: Colors.black,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                    fontSize: 30,
                  ),
                ),
                Text(
                  '(${user.email})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
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
