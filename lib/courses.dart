import 'package:flutter/material.dart';

class coursesPage extends StatefulWidget {
  const coursesPage({Key? key}) : super(key: key);

  @override
  courses_Page createState() => courses_Page();
}

class courses_PageState {}

class courses_Page extends State<coursesPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Courses',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Courses Available in VNR VJIET'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Computer Science and Engineering'),
              // subtitle: Text('Information about Title 1'),
              leading: CircleAvatar(
                child: Text('1'),
              ),
            ),
            ListTile(
              title: Text('Computer Science and Business Systems'),
              leading: CircleAvatar(
                child: Text('2'),
              ),
            ),
            ListTile(
              title: Text('CSE - Data Science '),
              leading: CircleAvatar(
                child: Text('3'),
              ),
            ),
            ListTile(
              title: Text('CSE - Artificial Intelligence and Machine Learning'),
              leading: CircleAvatar(
                child: Text('4'),
              ),
            ),
            ListTile(
              title: Text('CSE - Cyber Security'),
              leading: CircleAvatar(
                child: Text('5'),
              ),
            ),
            ListTile(
              title: Text('CSE - Internet of Things'),
              // subtitle: Text('Information about Title 1'),
              leading: CircleAvatar(
                child: Text('6'),
              ),
            ),
            ListTile(
              title: Text('Artificial Intelligence and Data Science'),
              // subtitle: Text('Information about Title 1'),
              leading: CircleAvatar(
                child: Text('7'),
              ),
            ),
            ListTile(
              title: Text('Electronics and Communication Engineering'),
              // subtitle: Text('Information about Title 1'),
              leading: CircleAvatar(
                child: Text('8'),
              ),
            ),
            ListTile(
              title: Text('Information Technology'),
              // subtitle: Text('Information about Title 1'),
              leading: CircleAvatar(
                child: Text('9'),
              ),
            ),
            ListTile(
              title: Text('Electrical and Electronics Engineering'),
              // subtitle: Text('Information about Title 1'),
              leading: CircleAvatar(
                child: Text('10'),
              ),
            ),
            ListTile(
              title: Text('Mechanical Engineering'),
              // subtitle: Text('Information about Title 1'),
              leading: CircleAvatar(
                child: Text('11'),
              ),
            ),
            ListTile(
              title: Text('Civil Engineering'),
              // subtitle: Text('Information about Title 1'),
              leading: CircleAvatar(
                child: Text('12'),
              ),
            ),
            ListTile(
              title: Text('Electronics & Instrumentation Engineering'),
              // subtitle: Text('Information about Title 1'),
              leading: CircleAvatar(
                child: Text('13'),
              ),
            ),
            ListTile(
              title: Text('Automobile Engineering'),
              // subtitle: Text('Information about Title 1'),
              leading: CircleAvatar(
                child: Text('14'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
