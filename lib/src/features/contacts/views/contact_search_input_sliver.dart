import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ContactSearchInputSliver extends StatefulWidget {
  const ContactSearchInputSliver({
    Key? key,
    this.onChanged,
    this.debounceTime,
  }) : super(key: key);
  final ValueChanged<String>? onChanged;
  final Duration? debounceTime;

  @override
  _ContactSearchInputSliverState createState() =>
      _ContactSearchInputSliverState();
}

class _ContactSearchInputSliverState extends State<ContactSearchInputSliver> {
  final StreamController<String> _textChangeStreamController =
      StreamController();
  late StreamSubscription _textChangesSubscription;
  List<ContactType> genderItems = [
    ContactType('One', 1),
    ContactType('two', 2),
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _textChangesSubscription = _textChangeStreamController.stream
        .debounceTime(
          widget.debounceTime ?? const Duration(seconds: 1),
        )
        .distinct()
        .listen((text) {
      final onChanged = widget.onChanged;
      if (onChanged != null) {
        onChanged(text);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(8),
          // height: 40,
          // decoration: BoxDecoration(
          //     color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Contact Name',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 17),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black26,
                                    offset: Offset(0, 2))
                              ],
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Text(
                                      'Contact Type',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Form(
                                    key: _formKey,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                              //Add isDense true and zero Padding.
                                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              //Add more decoration as you want here
                                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                            ),
                                            isExpanded: true,
                                            hint: const Text(
                                              'Select Your Type',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            items: genderItems
                                                .map((item) => DropdownMenuItem<
                                                        ContactType>(
                                                      value: item,
                                                      child: Text(
                                                        item.name!,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Select contact type.';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              //Do something when changing the item if you want.
                                            },
                                            onSaved: (value) {
                                              selectedValue =
                                                  value?.val.toString();
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              height: 60,
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 10),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 30,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();
                                              }
                                            },
                                            child: const Text('Submit Button'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            onChanged: _textChangeStreamController.add,
          ),
        ),
      );

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    super.dispose();
  }
}

class ContactType {
  String name;
  int val;

  ContactType(this.name, this.val);
}
