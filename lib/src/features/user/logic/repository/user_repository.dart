import 'package:indentsystem/src/features/auth/logic/models/user.dart';
import 'package:indentsystem/src/features/user/logic/provider/user_api_provider.dart';

class UserRepository {
  final _provider = UserAPIProvider();

  Future<User> getUser(String username) => _provider.getUser(username);
}
