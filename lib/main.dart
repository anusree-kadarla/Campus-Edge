// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minor/ConvexAppExample.dart';
import 'package:minor/rate_home.dart';
import 'package:minor/services/auth_service.dart';
import 'AdminHomePage.dart';
import 'Attendance.dart';
import 'adminlogin.dart';
import 'courses.dart';
import 'ebooks_veiw.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'YOUR_RECAPTCHA_SITE_KEY',
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: StreamBuilder(
        stream: AuthService().firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AdminHomePage();
          }
          return HomePage();
        },
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[900],
        //   colorScheme:
        //       ColorScheme.fromSwatch().copyWith(secondary: Colors.redAccent),
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  bool _isDarkMode = false;
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  Widget c = ConvexAppExample();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('Ebooks'),
                  onTap: () => selectedItem(context, 1),
                ),
                ListTile(
                  leading: Icon(Icons.bookmark),
                  title: Text('Courses'),
                  onTap: () => selectedItem(context, 3),
                ),
                ListTile(
                  leading: Icon(Icons.web),
                  title: Text('Attendence'),
                  onTap: () => selectedItem(context, 2),
                  // child: Text('Go to vnrvjiet.ac.in'),
                ),
                ListTile(
                  leading: Icon(Icons.rate_review),
                  title: Text('Rate us'),
                  onTap: () => selectedItem(context, 4),
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share app'),
                ),
                ListTile(
                  leading: Icon(Icons.call_to_action),
                  title: Text('Themes'),
                  onTap: _toggleTheme,
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Admin'),
                  onTap: () => selectedItem(context, 0),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: const Text('VNRVJIET'),
          ),
          body: c,
        ));
  }
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ebooks_veiw()));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Attendance(),
      ));
      break;
    case 3:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => coursesPage(),
      ));
      break;
    case 4:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AboutUsPage(),
      ));
      break;
    case 5:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConvexAppExample(),
      ));
      break;
    default:
      break;
  }
}
