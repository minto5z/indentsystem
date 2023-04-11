import 'package:bloc/bloc.dart';
import 'package:indentsystem/src/features/contacts/logic/models/contact_response.dart';

import '../repository/contact_repository.dart';

class ContactCubit extends Cubit<Data?> {
  ContactRepository contactRepository;

  ContactCubit({required this.contactRepository}) : super(null);
}
