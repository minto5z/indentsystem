import 'dart:io';

import 'package:indentsystem/src/features/auth/logic/interceptors/auth_token_interceptor.dart';
import 'package:indentsystem/src/features/auth/logic/models/login_response.dart';
import 'package:indentsystem/src/shared/logic/http/api.dart';

import '../../../../constants/environments.dart';
import '../../../../shared/logic/http/exception_state.dart';
import '../models/oauth_response.dart';

class AuthAPIProvider {
  Future<LoginResponse> authenticate(String username, String password) async {
    FormData formData = FormData.fromMap({
      'login_id': username,
      'password': password,
    });
    FormData oformData = FormData.fromMap({
      'grant_type': environments.grant_type,
      'client_id': environments.client_id,
      'client_secret': environments.client_secret
    });
    var otokens;
    try {
      final oauth = await api.post(
        '/oauth/token',
        data: oformData,
        options: Options(headers: {AuthTokenInterceptor.skipHeader: true}),
      );
      if (oauth.statusCode == 200) {
        otokens = OauthResponse.fromJson(oauth.data).accessToken;
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
    var tokens;
    try {
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
      if (response.statusCode == 200) {
        tokens = LoginResponse.fromJson(response.data);
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
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
    var tokens;
    try {
      final response = await api.post(
        '/oauth/token',
        data: {
          'grant_type': environments.grant_type,
          'client_id': environments.client_id,
          'client_secret': environments.client_secret
        },
        options: Options(headers: {AuthTokenInterceptor.skipHeader: true}),
      );

      if (response.statusCode == 200) {
        tokens = OauthResponse.fromJson(response.data);
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
    return tokens;
  }
}
