import 'package:equatable/equatable.dart';
import 'package:indentsystem/src/features/auth/logic/models/user.dart';

class Typing extends Equatable {
  late final User user;

  Typing({required this.user}) : super();

  Typing.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
  }

  @override
  List<Object?> get props => [user];
}
