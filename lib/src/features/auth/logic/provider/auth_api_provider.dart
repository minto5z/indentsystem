import 'dart:io';

import 'package:indentsystem/src/features/auth/logic/interceptors/auth_token_interceptor.dart';
import 'package:indentsystem/src/features/auth/logic/models/login_response.dart';
import 'package:indentsystem/src/shared/logic/http/api.dart';

import '../models/oauth_response.dart';

class AuthAPIProvider {
  Future<LoginResponse> authenticate(String username, String password) async {
    FormData formData = FormData.fromMap({
      'login_id': username,
      'password': password,
    });
    FormData oformData = FormData.fromMap({
      'grant_type': 'client_credentials',
      'client_id': 1,
      'client_secret': '8mViQY5U5YbhZ8bQRGhIlQP4eqnaeviCp9FYHgK4'
    });
    final oauth = await api.post(
      '/oauth/token',
      data: oformData,
      options: Options(headers: {AuthTokenInterceptor.skipHeader: true}),
    );

    final otokens = OauthResponse.fromJson(oauth.data).accessToken;
    final response = await api.post(
      '/api/admin/login',
      options: Options(
        headers: {
          Headers.acceptHeader: true,
          HttpHeaders.authorizationHeader: "Bearer $otokens",
        },
      ),
      data: formData,
    );

    final tokens = LoginResponse.fromJson(response.data);

    return tokens;
  }

  Future<void> recover(String email) async {
    await api.post(
      '/recover',
      data: {
        'email': email,
      },
    );
  }

  Future<OauthResponse> loginWithRefreshToken() async {
    final response = await api.post(
      '/oauth/token',
      data: {
        'grant_type': 'client_credentials',
        'client_id': 1,
        'client_secret': '8mViQY5U5YbhZ8bQRGhIlQP4eqnaeviCp9FYHgK4'
      },
      options: Options(headers: {AuthTokenInterceptor.skipHeader: true}),
    );

    return OauthResponse.fromJson(response.data);
  }
}
