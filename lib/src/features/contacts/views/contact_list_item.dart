import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/views/widgets/cache_image_network.dart';
import '../logic/models/contact_response.dart';

class ContactListItem extends StatelessWidget {
  const ContactListItem({
    required this.contact,
    Key? key,
  }) : super(key: key);

  final Data contact;

  @override
  Widget build(BuildContext context) {
    final contactCardContent = Container(
      margin: const EdgeInsets.all(16.0),
      //constraints: const BoxConstraints.expand(),
      child: SizedBox(
        height: 4,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    //Container(height: 5.0),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: 'Click profile picture',
                                toastLength: Toast.LENGTH_SHORT);
                          },
                          child: Hero(
                            tag: 'profilePicture',
                            child: ClipOval(
                              child: buildCacheNetworkImage(
                                  url:
                                  'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg',
                                  width: 30),
                            ),
                          ),
                        ),
                        Container(width: 5.0),
                        Text(contact.name??'name',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold,color: Colors.purple)),
                      ],
                    ),
                    Container(width: 5.0),
                    Text(contact.email??'email@gmail.com'),
                    Container(height: 5.0),
                    Text(contact.phone ?? '01755262353'),
                    Text(
                      contact.company??'company name',
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.contact_page,color: Colors.purple,),
                        Container(width: 2.0),
                        Icon(Icons.email,color: Colors.purple,),
                        Container(width: 2.0),
                        Icon(Icons.location_history,color: Colors.purple,),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final contactCard = Card(
      elevation: 10,
      child: SizedBox(
        height: 135.0,
        child: contactCardContent,
      ),
    );

    return Container(
      height: 145.0,
      margin: const EdgeInsets.only(bottom: 2.0,left: 16,right: 16),
      child: Column(
        children: <Widget>[
          contactCard,
        ],
      ),
    );
  }
}
