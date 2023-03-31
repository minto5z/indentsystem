import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:indentsystem/src/app.dart';
import 'package:indentsystem/src/features/auth/logic/cubit/auth_cubit.dart';
import 'package:indentsystem/src/features/auth/logic/models/oauth_response.dart';
import 'package:indentsystem/src/features/auth/logic/repository/auth_repository.dart';
import 'package:provider/provider.dart';

class AuthTokenInterceptor extends Interceptor {
  static const skipHeader = 'skipAuthToken';

  Dio api;

  AuthTokenInterceptor(this.api);

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final context = applicationKey.currentContext;

    final repository = context?.read<AuthRepository>();

    if (repository == null) {
      return;
    }

    final accessToken = await repository.getAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return super.onRequest(options, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    final context = applicationKey.currentContext;

    if (context == null) {
      return;
    }

    final response = err.response?.data;

    if (response == null) {
      return super.onError(err, handler);
    }

    final repository = context.read<AuthRepository>();

    if (err.response?.statusCode == 401 &&
        await repository.getRefreshToken() != null) {
      return _handlerRefreshToken(context, repository, err, handler);
    }

    return super.onError(err, handler);
  }

  _handlerRefreshToken(
    BuildContext context,
    AuthRepository repository,
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    if (requestOptions.headers.containsKey(skipHeader)) {
      return super.onError(err, handler);
    }

    final refreshToken = await repository.getRefreshToken();
    FormData formData = FormData.fromMap({
      'grant_type': 'client_credentials',
      'client_id': 1,
      'client_secret': '8mViQY5U5YbhZ8bQRGhIlQP4eqnaeviCp9FYHgK4'
    });
    try {
      final response = await api.post(
        '/oauth/token',
        data: formData,
        options: Options(headers: {AuthTokenInterceptor.skipHeader: true}),
      );

      final tokens = OauthResponse.fromJson(response.data);

      await repository.setOauthTokens(tokens);

      try {
        final headers = requestOptions.headers;

        headers[skipHeader] = true;

        final finalResponse = await api.request(
          requestOptions.path,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          queryParameters: requestOptions.queryParameters,
          options: Options(
            method: requestOptions.method,
            headers: headers,
          ),
        );

        return handler.resolve(finalResponse);
      } on DioError catch (e) {
        return handler.next(e);
      } catch (e) {
        return super.onError(err, handler);
      }
    } catch (e) {
      await context.read<AuthCubit>().logout();

      return super.onError(err, handler);
    }
  }
}
