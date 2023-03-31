import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as store;
import 'package:indentsystem/src/features/auth/logic/models/login_response.dart';
import 'package:indentsystem/src/features/auth/logic/provider/auth_api_provider.dart';

import '../models/oauth_response.dart';

class AuthRepository {
  final _provider = AuthAPIProvider();
  late final _storage = const store.FlutterSecureStorage();

  String getDeviceType() {
    String type = 'web';

    if (Platform.isIOS) {
      type = 'ios';
    }

    if (Platform.isAndroid) {
      type = 'android';
    }

    return type;
  }

  Future<void> logout() async {
    await deleteAccessToken();
    await deleteRefreshToken();
    await deleteUser();
  }

  Future<UserInfo?> getProfile() async {
    if (await getUser() == null) {
      return null;
    }

    try {
      final profile = await getUser();
      Map<String, dynamic> json = jsonDecode(profile!);
      var user = UserInfo.fromJson(json);
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> authenticate(String username, String password) async {
    return setTokens(
      await _provider.authenticate(username, password),
    );
  }

  Future<void> loginWithRefreshToken() async {
    return setOauthTokens(
      await _provider.loginWithRefreshToken(),
    );
  }

  Future<void> recover(String email) {
    return _provider.recover(email);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: 'accessToken');
  }

  Future<void> setAccessToken(String? token) {
    return _storage.write(key: 'accessToken', value: token);
  }

  Future<String?> getUser() {
    return _storage.read(key: 'user');
  }

  Future<void> setUser(String? user) {
    return _storage.write(key: 'user', value: user);
  }

  Future<void> deleteUser() {
    return _storage.delete(key: 'user');
  }

  Future<void> deleteAccessToken() {
    return _storage.delete(key: 'accessToken');
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: 'refreshToken');
  }

  Future<void> setRefreshToken(String token) {
    return _storage.write(key: 'refreshToken', value: token);
  }

  Future<void> deleteRefreshToken() {
    return _storage.delete(key: 'refreshToken');
  }

  Future<void> setTokens(LoginResponse response) async {
    await setAccessToken(response.userInfo?.token);
    String user = jsonEncode(response.userInfo?.toJson());
    await setUser(user);
  }

  Future<void> setOauthTokens(OauthResponse response) async {
    await setAccessToken(response.accessToken);
    //await setRefreshToken(tokens.refreshToken);
  }
}
