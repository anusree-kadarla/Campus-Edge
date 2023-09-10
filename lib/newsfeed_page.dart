import 'package:flutter/material.dart';

class NewsfeedPage extends StatelessWidget {
  const NewsfeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newsfeed'),
      ),
      body: ListView(
        children: List.generate(5, (index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text('News $index'),
            subtitle: const Text('This is some news.'),
          );
        }),
      ),
    );
  }
}
