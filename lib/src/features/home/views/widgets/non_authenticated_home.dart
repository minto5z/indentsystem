import 'package:flutter/material.dart';
import 'package:indentsystem/src/features/auth/views/screens/login_screen.dart';
import 'package:indentsystem/src/features/auth/views/screens/register_screen.dart';
import 'package:indentsystem/src/shared/views/widgets/circles_background.dart';
import 'package:indentsystem/src/shared/views/widgets/underlined_button.dart';

class NonAuthenticatedHome extends StatelessWidget {
  const NonAuthenticatedHome({Key? key}) : super(key: key);

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
            Row(
              children: [
                const Text(
                  'by ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  'Denzel Code',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.highlightColor,
                    fontSize: 30,
                  ),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                UnderlinedButton(
                  color: theme.secondaryHeaderColor,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    LoginScreen.routeName,
                  ),
                  child: const Text('Sign In'),
                ),
                const Spacer(),
                UnderlinedButton(
                  color: theme.highlightColor,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    RegisterScreen.routeName,
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
