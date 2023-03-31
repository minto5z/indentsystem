import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indentsystem/src/features/auth/logic/cubit/auth_cubit.dart';
import 'package:indentsystem/src/features/auth/views/screens/login_screen.dart';
import 'package:indentsystem/src/features/home/views/widgets/authenticated_home.dart';

import '../../../auth/logic/models/login_response.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  static route() => MaterialPageRoute(builder: (_) => HomeScreen());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bloc = context.read<AuthCubit>();

    return Scaffold(
      body: FutureBuilder(
        future: bloc.updateProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocBuilder<AuthCubit, UserInfo?>(
              buildWhen: (prev, curr) => prev?.id != curr?.id,
              builder: (context, user) {
                return user != null
                    ? AuthenticatedHome(user: user)
                    : const LoginScreen();
                //: const NonAuthenticatedHome();
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(
              color: theme.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
