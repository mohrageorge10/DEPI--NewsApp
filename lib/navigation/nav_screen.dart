import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/home.dart';
import 'package:news_app/saved/saved_screen.dart';
import 'package:news_app/search/search_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late List<Widget> pages = [
    Home(),
    SearchScreen(),
    SavedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    List<CurvedNavigationBarItem> navBarItems = [
      CurvedNavigationBarItem(
        child: Icon(
          _page == 0 ? Icons.home : Icons.home_outlined,
          color: Colors.white,
        ),
        label: _page == 0 ? 'Home' : null,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
      CurvedNavigationBarItem(
        child: Icon(
          _page == 1 ? Icons.search : Icons.search,
          color: Colors.white,
        ),
        label: _page == 1 ? 'Search' : null,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
      CurvedNavigationBarItem(
        child: Icon(
          _page == 2 ? Icons.bookmark : Icons.bookmark_border,
          color: Colors.white,
        ),
        label: _page == 2 ? 'Save' : null,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: navBarItems,
        color: Color(0xff001F3F),
        buttonBackgroundColor: Color(0xffFFA500),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: IndexedStack(index: _page, children: pages),
    );
  }
}
