import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indentsystem/src/features/auth/logic/cubit/auth_cubit.dart';
import 'package:indentsystem/src/features/auth/logic/models/login_response.dart';
import 'package:indentsystem/src/features/settings/logic/settings_repository.dart';
import 'package:indentsystem/src/shared/views/widgets/dialog/alert_dialog_widget.dart';
import 'package:indentsystem/src/shared/views/widgets/dialog/confirm_dialog_widget.dart';
import 'package:indentsystem/src/shared/views/widgets/main_text_field.dart';

import '../../../../shared/views/widgets/global_widget.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  static route() => MaterialPageRoute(builder: (_) => SettingsScreen());

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _repository = SettingsRepository();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _loading = false;
  final _globalWidget = GlobalWidget();

  @override
  void initState() {
    super.initState();

    final user = context.read<AuthCubit>().state;

    if (user != null) {
      _usernameController.text = user.email!;
      _emailController.text = user.email ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final node = FocusScope.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _globalWidget.globalAppBar(context),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('widget.user.email!'),
            accountEmail: Text('widget.user.email!'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("A", style: TextStyle(fontSize: 40.0)),
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Item 2'),
            leading: const Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Close this drawer'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      )),
      body: BlocBuilder<AuthCubit, UserInfo?>(
        builder: (context, state) {
          return ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Update Username',
                      style: theme.textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MainTextField(
                            controller: _usernameController,
                            label: 'Username',
                            loginidField: true,
                            onSubmitted: (_) => _updateUsername(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            onPressed: () => _updateUsername(),
                            child: Text('Update'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Update Email',
                      style: theme.textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MainTextField(
                            label: 'Email',
                            controller: _emailController,
                            emailField: true,
                            onSubmitted: (_) => _updateEmail(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            onPressed: () => _updateEmail(),
                            child: Text('Update'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Update Password',
                      style: theme.textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (state != null)
                            Column(
                              children: [
                                MainTextField(
                                  controller: _currentPasswordController,
                                  label: 'Current Password',
                                  passwordField: true,
                                  onEditingComplete: () => node.nextFocus(),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          MainTextField(
                            controller: _passwordController,
                            label: 'New Password',
                            passwordField: true,
                            onEditingComplete: () => node.nextFocus(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MainTextField(
                            controller: _confirmPasswordController,
                            label: 'Confirm Password',
                            passwordField: true,
                            onSubmitted: (_) => _updatePassword(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            onPressed: () => _updatePassword(),
                            child: Text('Update'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _updateUsername() async {
    setState(() {
      _loading = true;
    });

    try {
      await _repository.updateUsername(
        _usernameController.text,
      );

      await showDialog(
        context: context,
        builder: (_) => AlertDialogWidget(
          title: 'Good job!',
          description: 'Your username was sucessfully updated!',
        ),
      );

      await _updateLoggedUser();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  _updateEmail() async {
    setState(() {
      _loading = true;
    });

    try {
      await _repository.updateEmail(
        _emailController.text,
      );

      await showDialog(
        context: context,
        builder: (_) => AlertDialogWidget(
          title: 'Good job!',
          description: 'Your email was sucessfully updated!',
        ),
      );

      await _updateLoggedUser();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _updateLoggedUser() {
    return context.read<AuthCubit>().updateProfile();
  }

  _updatePassword() async {
    setState(() {
      _loading = true;
    });

    try {
      await _repository.updatePassword(
        _currentPasswordController.text,
        _passwordController.text,
        _confirmPasswordController.text,
      );

      await _confirmLogout();

      await showDialog(
        context: context,
        builder: (_) => AlertDialogWidget(
          title: 'Good job!',
          description: 'Your password was sucessfully updated!',
        ),
      );
    } finally {
      _passwordController.text = '';
      _confirmPasswordController.text = '';
      _currentPasswordController.text = '';

      setState(() {
        _loading = false;
      });
    }
  }

  _confirmLogout() async {
    final response = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialogWidget(
        title: 'Global logout',
        description: 'Do you want to logout from all of your devices?',
      ),
    );

    if (response != null && response) {
      await _logoutFromAllDevices();
    }
  }

  _logoutFromAllDevices() async {
    //await context.read<AuthCubit>().logoutFromAllDevices();
    //
    // await notificationRepository.requestPermission();
  }
}
