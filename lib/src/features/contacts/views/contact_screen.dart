import 'package:flutter/material.dart';

import '../../../shared/views/widgets/global_widget.dart';

class ContactScreen extends StatefulWidget {
  static const routeName = '/contact';
  static route() => MaterialPageRoute(builder: (_) => ContactScreen());
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // initialize global widget
  final _globalWidget = GlobalWidget();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<String> _data = ['item 1', 'item 2', 'item 3', 'item 4', 'item 5'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _globalWidget.globalAppBar(context),
        drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const UserAccountsDrawerHeader(
                  accountName: Text('widget.user.email!'),
                  accountEmail: Text('widget.user.email!'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text("A", style: TextStyle(fontSize: 40.0)),
                  ),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Item 2'),
                  leading: const Icon(Icons.arrow_forward),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Close this drawer'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )),
        body: AnimatedList(
          // Key to call remove and insert item methods from anywhere
          key: _listKey,
          initialItemCount: _data.length,
          itemBuilder: (context, index, animation) {
            return _buildItem(_data[index], animation, index);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: (){
            
          },
        )
    );
  }

  Widget _buildItem(String item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Card(
          elevation: 5.0,
          child: ListTile(
            title: Text(
              item,
              style: TextStyle(fontSize: 20),
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
              onTap: (){
              },
            ),
          ),
        ),
      ),
    );
  }
}
