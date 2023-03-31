import 'package:flutter/material.dart';
import 'package:indentsystem/src/features/auth/views/screens/login_screen.dart';
import 'package:indentsystem/src/features/auth/views/screens/recover_screen.dart';
import 'package:indentsystem/src/features/auth/views/screens/register_screen.dart';
import 'package:indentsystem/src/features/home/views/screens/home_screen.dart';
import 'package:indentsystem/src/features/settings/views/screens/settings_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case RegisterScreen.routeName:
        return RegisterScreen.route();
      case RecoverScreen.routeName:
        return RecoverScreen.route();
      case SettingsScreen.routeName:
        return SettingsScreen.route();
      default:
        return HomeScreen.route();
    }
  }
}
