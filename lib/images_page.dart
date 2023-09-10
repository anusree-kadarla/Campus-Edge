import 'package:flutter/material.dart';

class ImagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Images'),
    ),
    body: Scrollbar(
        child:GridView.count(
          crossAxisCount: 2,
          children: List.generate(10, (index) {
            return Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/200?random=$index'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        ),
    ),
    );
  }
}
