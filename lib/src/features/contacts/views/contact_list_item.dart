import 'package:flutter/material.dart';

import '../logic/models/contact_response.dart';

/// List item representing a single Character with its photo and name.
class ContactListItem extends StatelessWidget {
  const ContactListItem({
    required this.contact,
    Key? key,
  }) : super(key: key);

  final Data contact;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(contact.name!),
      );
}
