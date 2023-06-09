import 'package:dio/dio.dart';
import 'package:indentsystem/src/constants/environments.dart';
import 'package:indentsystem/src/features/auth/logic/interceptors/auth_token_interceptor.dart';
import 'package:indentsystem/src/shared/logic/http/interceptors/error_dialog_interceptor.dart';

export 'package:dio/dio.dart';

Dio _createHttpClient() {
  final api = Dio(
    BaseOptions(
      baseUrl: environments.api,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  api
    ..interceptors.add(ErrorDialogInterceptor())
    ..interceptors.add(AuthTokenInterceptor(api));

  return api;
}

final api = _createHttpClient();
