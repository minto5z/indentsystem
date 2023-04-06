import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indentsystem/src/features/auth/views/screens/login_screen.dart';
import 'package:indentsystem/src/features/contacts/views/contact_screen.dart';

import '../../../../shared/views/widgets/cache_image_network.dart';
import '../../../../shared/views/widgets/global_widget.dart';
import '../../../auth/logic/cubit/auth_cubit.dart';
import '../../../auth/logic/models/login_response.dart';
import '../models/banner_slider_model.dart';
import '../models/category_model.dart';

class AuthenticatedHome extends StatefulWidget {
  final UserInfo user;

  const AuthenticatedHome({super.key, required this.user});

  @override
  _Home1PageState createState() => _Home1PageState();
}

class _Home1PageState extends State<AuthenticatedHome> {
  // initialize global widget
  final _globalWidget = GlobalWidget();

  final Color _color1 = const Color(0xFF005288);
  final Color _color2 = const Color(0xFF37474f);

  int _currentImageSlider = 0;

  List<BannerSliderModel> _bannerData = [];
  List<CategoryModel> _categoryData = [];

  @override
  void initState() {
    _bannerData.add(BannerSliderModel(
        id: 1,
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _bannerData.add(BannerSliderModel(
        id: 2,
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _bannerData.add(BannerSliderModel(
        id: 3,
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _bannerData.add(BannerSliderModel(
        id: 4,
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _bannerData.add(BannerSliderModel(
        id: 5,
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));

    _categoryData.add(CategoryModel(
        id: 1,
        name: 'Contacts Page',
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _categoryData.add(CategoryModel(
        id: 2,
        name: 'Product',
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _categoryData.add(CategoryModel(
        id: 3,
        name: 'Buy Online',
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _categoryData.add(CategoryModel(
        id: 4,
        name: 'Apply for Credit',
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _categoryData.add(CategoryModel(
        id: 5,
        name: 'Credit\nApplication\nStatus',
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _categoryData.add(CategoryModel(
        id: 6,
        name: 'Credit Payment',
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _categoryData.add(CategoryModel(
        id: 7,
        name: 'Commission',
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _categoryData.add(CategoryModel(
        id: 8,
        name: 'Check Point',
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));
    _categoryData.add(CategoryModel(
        id: 9,
        name: 'Contact Us',
        image:
            'https://cdn.dribbble.com/users/4009983/screenshots/16047199/media/5ebee3eea85f65f654414699c4a75f00.jpg'));

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
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.email!),
              accountEmail: Text(widget.user.email!),
              currentAccountPicture: const CircleAvatar(
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
        body: ListView(
          children: [_buildTop(), _buildHomeBanner(), _createMenu()],
        ));
  }

  Widget _buildTop() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
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
                    width: 50),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: 'Click name', toastLength: Toast.LENGTH_SHORT);
                    },
                    child: Text(
                      widget.user.email!,
                      style: TextStyle(
                          color: _color2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: 'Click platinum member',
                          toastLength: Toast.LENGTH_SHORT);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(top: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 6),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: _color2, size: 12),
                            const SizedBox(width: 4),
                            Text('platinum member',
                                maxLines: 1,
                                style: TextStyle(
                                    color: _color2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9))
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            width: 1,
            height: 40,
            color: Colors.grey[300],
          ),
          GestureDetector(
            onTap: () {
              // Fluttertoast.showToast(
              //     msg: 'Click log out', toastLength: Toast.LENGTH_SHORT);
              context.read<AuthCubit>().logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName,
                (route) => false,
              );
            },
            child: Text('Log Out',
                style: TextStyle(color: _color2, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildHomeBanner() {
    return Stack(
      children: [
        CarouselSlider(
          items: _bannerData
              .map((item) => GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: 'Click banner ${item.id}',
                        toastLength: Toast.LENGTH_SHORT);
                  },
                  child: buildCacheNetworkImage(
                      width: 0, height: 0, url: item.image)))
              .toList(),
          options: CarouselOptions(
              aspectRatio: 2,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 300),
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageSlider = index;
                });
              }),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _bannerData.map((item) {
              int index = _bannerData.indexOf(item);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: _currentImageSlider == index ? 10 : 5,
                height: _currentImageSlider == index ? 10 : 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _createMenu() {
    return GridView.count(
      childAspectRatio: 1.1,
      shrinkWrap: true,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: 3,
      children: List.generate(_categoryData.length, (index) {
        return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  ContactScreen.routeName,
                  (route) => false,
                );
              } else {
                Fluttertoast.showToast(
                    msg:
                        'Click ${_categoryData[index].name.replaceAll('\n', ' ')}',
                    toastLength: Toast.LENGTH_SHORT);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[100]!, width: 0.5),
                  color: Colors.white),
              padding: const EdgeInsets.all(8),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    buildCacheNetworkImage(
                        width: 40,
                        height: 40,
                        url: _categoryData[index].image,
                        plColor: Colors.transparent),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: Text(
                        _categoryData[index].name,
                        style: TextStyle(
                          color: _color1,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ])),
            ));
      }),
    );
  }
}
