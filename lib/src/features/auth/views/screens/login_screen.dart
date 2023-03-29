import 'package:indentsystem/src/features/auth/logic/cubit/auth_cubit.dart';
import 'package:indentsystem/src/features/auth/views/screens/recover_screen.dart';
import 'package:indentsystem/src/features/auth/views/screens/register_screen.dart';
import 'package:indentsystem/src/features/home/views/screens/home_screen.dart';
import 'package:indentsystem/src/shared/views/widgets/circles_background.dart';
import 'package:indentsystem/src/shared/views/widgets/go_back_button.dart';
import 'package:indentsystem/src/shared/views/widgets/main_text_field.dart';
import 'package:indentsystem/src/shared/views/widgets/next_button.dart';
import 'package:indentsystem/src/shared/views/widgets/scrollable_form.dart';
import 'package:indentsystem/src/shared/views/widgets/underlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  static route() => MaterialPageRoute(builder: (_) => LoginScreen());

  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordController = TextEditingController();

  String _username = '';
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final node = FocusScope.of(context);

    return Scaffold(
      body: CirclesBackground(
        backgroundColor: Colors.white,
        topSmallCircleColor: theme.secondaryHeaderColor,
        topMediumCircleColor: theme.primaryColor,
        topRightCircleColor: theme.highlightColor,
        bottomRightCircleColor: Colors.white,
        child: Stack(
          children: [
            GoBackButton(),
            Column(
              children: [
                ScrollableForm(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 250),
                          child: Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 46,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        _form(node, context),
                      ],
                    ),
                  ],
                ),
                _FooterButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _form(FocusScopeNode node, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTextField(
          label: 'Username',
          usernameField: true,
          onChanged: (value) => setState(() {
            _username = value;
          }),
          onEditingComplete: () => node.nextFocus(),
        ),
        SizedBox(
          height: 20,
        ),
        MainTextField(
          label: 'Password',
          controller: _passwordController,
          passwordField: true,
          onSubmitted: (_) {
            node.unfocus();

            _login(context);
          },
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              'Sign In',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Spacer(),
            NextButton(
              onPressed: () => _login(context),
              loading: _loading,
            )
          ],
        ),
      ],
    );
  }

  _login(BuildContext context) {
    final bloc = context.read<AuthCubit>();

    _loginWith(
      context,
      () => bloc.authenticate(
        _username,
        _passwordController.text,
      ),
    );
  }

  _loginWith(BuildContext context, Future<void> Function() method) async {
    if (_loading) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await method();

      Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName,
        (route) => false,
      );
    } finally {
      setState(() {
        _loading = false;
      });

      _passwordController.text = '';
    }
  }
}

class _FooterButtons extends StatelessWidget {
  const _FooterButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          // UnderlinedButton(
          //   onPressed: () => Navigator.pushNamed(
          //     context,
          //     RegisterScreen.routeName,
          //   ),
          //   child: Text('Sign Up'),
          //   color: theme.highlightColor,
          // ),
          const Spacer(),
          UnderlinedButton(
            onPressed: () => Navigator.pushNamed(
              context,
              RecoverScreen.routeName,
            ),
            color: theme.secondaryHeaderColor,
            child: const Text('Forgot Password'),
          )
        ],
      ),
    );
  }
}
