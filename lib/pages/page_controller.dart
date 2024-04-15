import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_education/components/post_card.dart';
import 'package:flex_education/models/course.dart';
import 'package:flex_education/pages/community_page.dart';
import 'package:flex_education/pages/home_page.dart';
import 'package:flex_education/pages/learning_roadmap.dart';
import 'package:flex_education/pages/profile_page.dart';
import 'package:flex_education/pages/search_page.dart';
import 'package:flex_education/services/authentication__service.dart';
import 'package:flex_education/services/firebase_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class PageController extends StatefulWidget {
  PageController();

  @override
  State<PageController> createState() => _PageControllerState();
}

class _PageControllerState extends State<PageController> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //AuthenticationService.instance().signOut();
    Provider.of<MyProvider>(context, listen: false).write();
    Provider.of<MyProvider>(context, listen: false).getUser();
    AuthenticationService auth = Provider.of<AuthenticationService>(context);
    List<Widget> _widgetOptions = <Widget>[
      HomePage(),
      SearchPage(),
      CommunityPage(),
      ProfilePage(),
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 10, 10),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color.fromARGB(255, 129, 133, 240),
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: CupertinoIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: CupertinoIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: CupertinoIcons.group,
                  text: 'Community',
                  iconSize: 30,
                ),
                GButton(
                  icon: CupertinoIcons.pencil_circle,
                  text: 'Profile',
                  iconSize: 30,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
