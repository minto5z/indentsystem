import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as store;
import 'package:indentsystem/src/features/auth/logic/models/login_response.dart';

import '../provider/contact_api_provider.dart';

class ContactRepository {
  final _provider = ContactAPIProvider();
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
}
