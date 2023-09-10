// ignore_for_file: library_private_types_in_public_api

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'faculty_page.dart';
import 'images_page.dart';
import 'newsfeed_page.dart';
import 'images_u.dart';
import 'images_v.dart';

class ConvexAppExample extends StatefulWidget {
  const ConvexAppExample({super.key});

  @override
  _ConvexAppExampleState createState() => _ConvexAppExampleState();
}

class _ConvexAppExampleState extends State<ConvexAppExample> {
  final TabStyle _tabStyle = TabStyle.reactCircle;
  PageController pc = PageController(initialPage: 0);
  int ci = 0;
  Widget cen = const NewsfeedPage();
  void setty(int ci) {
    if (ci == 1) {
      cen = FacultyPage();
    } else if (ci == 2) {
      cen = ImagesView();
    } else {
      cen = const NewsfeedPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        body: PageView(
          controller: pc,
          children: [
            Container(
              child: NewsfeedPage(),
            ),
            Container(
              child: FacultyPage(),
            ),
            Container(
              child: ImagesView(),
            ),
          ],
          onPageChanged: (int ind) {
            setState(() {
              ci = ind;
            });
          },
        ),
        // body: cen,
        bottomNavigationBar: //ConvexAppBar.badge(
            //   // Optional badge argument: keys are tab indices, values can be
            //   // String, IconData, Color or Widget.
            //   const <int, dynamic>{1: ''},
            //   // initialActiveIndex: ci,
            //   style: _tabStyle,
            //   items: const <TabItem>[
            //     TabItem(icon: Icons.newspaper, title: "feed"),
            //     TabItem(icon: Icons.person_pin, title: "faculty"),
            //     TabItem(icon: Icons.image, title: "events"),
            //   ],
            BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 40, 38, 38),
          currentIndex: ci,
          selectedIconTheme: IconThemeData(size: 42),
          unselectedIconTheme: IconThemeData(size: 36),
          unselectedItemColor: Color.fromARGB(255, 234, 228, 228),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              label: 'Faculty',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'event',
            ),
          ],
          onTap: (int index) {
            setState(() {
              ci = index;
              pc.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
          },
        ),
      ),
    );
  }
}
