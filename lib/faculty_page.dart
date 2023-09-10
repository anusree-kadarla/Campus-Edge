import 'package:flutter/material.dart';

class FacultyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty'),
      ),
      body: ListView(
        children: List.generate(5, (index) {
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://picsum.photos/200?random=$index'),
                  ),
                  title: Text('Faculty $index'),
                  subtitle: Text('Department'),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Some information about the faculty.'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
