import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:covid19_info/ui/styles/styles.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(64.0),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.5)),
          ],
        ),
        child: GNav(
          gap: 8,
          iconSize: 20,
          activeColor: Colors.white,
          duration: Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: Entypo.moon,
              text: 'Nepal',
              iconColor: Colors.red,
              backgroundColor: Colors.red,
            ),
            GButton(
              icon: Entypo.news,
              text: 'News',
              iconColor: Colors.green,
              backgroundColor: Colors.green,
            ),
            GButton(
              icon: Entypo.info_with_circle,
              text: 'Info',
              iconColor: Colors.blue,
              backgroundColor: Colors.blue,
            ),
            GButton(
              icon: Entypo.globe,
              text: 'World',
              iconColor: Colors.yellow,
              backgroundColor: Colors.yellow,
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          Container(),
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
