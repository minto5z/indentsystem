import 'package:bloc/bloc.dart';
import 'package:indentsystem/src/features/auth/logic/repository/auth_repository.dart';

import '../models/login_response.dart';

class AuthCubit extends Cubit<UserInfo?> {
  AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(null);

  Future<void> authenticate(String username, String password) async {
    return _loginWith(() => authRepository.authenticate(username, password));
  }

  // Future<void> register(String username, String password, String email) async {
  //   return _loginWith(() => authRepository.register(username, password, email));
  // }

  // Future<void> logoutFromAllDevices() async {
  //   return _loginWith(() => authRepository.logoutFromAllDevices());
  // }

  Future<void> _loginWith(Function method) async {
    await method();

    return updateProfile();
  }

  Future<void> logout() async {
    emit(null);

    await authRepository.logout();
  }

  Future<void> updateProfile() async {
    emit(await authRepository.getProfile());
  }
}
