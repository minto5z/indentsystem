import 'package:flutter/material.dart';
import 'package:indentsystem/src/features/auth/views/screens/login_screen.dart';
import 'package:indentsystem/src/features/auth/views/screens/recover_screen.dart';
import 'package:indentsystem/src/features/home/views/screens/home_screen.dart';
import 'package:indentsystem/src/features/settings/views/screens/settings_screen.dart';

import 'features/contacts/views/contact_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case RecoverScreen.routeName:
        return RecoverScreen.route();
      case SettingsScreen.routeName:
        return SettingsScreen.route();
      case ContactScreen.routeName:
        return ContactScreen.route();
      default:
        return HomeScreen.route();
    }
  }
}
