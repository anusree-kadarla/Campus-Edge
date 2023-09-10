import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ebooks_home.dart';
import 'images_home.dart';
import 'main.dart';

class AdminHomePage extends StatelessWidget {
  static const routeName = '/admin-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp())
              );
            },
            icon: Icon(Icons.logout),
            label: Text("Signout"),
            style: TextButton.styleFrom(
                primary: Colors.white
            ),
          ),

        ],
      ),

        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Card(
                child: InkWell(
                  onTap: () {
                    // Navigate to event images screen
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => imghome()
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event,
                        size: 80.0,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Event Images',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Card(
                child: InkWell(
                  onTap: () {
                    // Navigate to newsfeed screen
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.article,
                        size: 80.0,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Newsfeed',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Card(
                child: InkWell(
                  onTap: () {
                    // Navigate to ebooks screen
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ebooks_home()
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book,
                        size: 80.0,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Ebooks',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
