import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:indentsystem/src/features/auth/logic/interceptors/auth_token_interceptor.dart';
import 'package:indentsystem/src/features/auth/logic/models/login_response.dart';
import 'package:indentsystem/src/shared/logic/http/api.dart';

import '../../../../constants/environments.dart';
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

      otokens = OauthResponse.fromJson(oauth.data).accessToken;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        Fluttertoast.showToast(
            msg: '{$e.response?.statusCode}', toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(msg: e.message, toastLength: Toast.LENGTH_SHORT);
      }
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

      tokens = LoginResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        Fluttertoast.showToast(
            msg: '{$e.response?.statusCode}', toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(msg: e.message, toastLength: Toast.LENGTH_SHORT);
      }
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
      tokens = OauthResponse.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        Fluttertoast.showToast(
            msg: '{$e.response?.statusCode}', toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(msg: e.message, toastLength: Toast.LENGTH_SHORT);
      }
    }
    return tokens;
  }
}
