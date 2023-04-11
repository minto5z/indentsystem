import 'dart:io';

import 'package:indentsystem/src/features/contacts/logic/models/contact_response.dart';

import '../../../../shared/logic/http/api.dart';
import '../../../../shared/logic/http/exception_state.dart';
import '../../../auth/logic/interceptors/auth_token_interceptor.dart';

class ContactAPIProvider {
  static Future<ContactResponse> getCharacterList(
    int offset,
    int limit, {
    String? searchTerm,
    String? accessToken,
  }) async {
    try {
      final response = await api.get(
        _ApiUrlBuilder.characterList(offset, limit, searchTerm: searchTerm)
            .toString(),
        options: Options(headers: {AuthTokenInterceptor.skipHeader: true}),
      );

      if (response.statusCode == 200) {
        return ContactResponse.fromJson(response.data);
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
  }
}

class _ApiUrlBuilder {
  static const _baseUrl = '/backend/api/hrm/contacts';

  static Uri characterList(
    int offset,
    int limit, {
    String? searchTerm,
  }) =>
      Uri.parse(
        '$_baseUrl?'
        'offset=$offset'
        '&limit=$limit'
        '${_buildSearchTermQuery(searchTerm)}',
      );

  static String _buildSearchTermQuery(String? searchTerm) =>
      searchTerm != null && searchTerm.isNotEmpty
          ? '&type=${searchTerm.replaceAll(' ', '+').toLowerCase()}'
          : '';
}
