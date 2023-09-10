import 'package:flutter/material.dart';

import 'ebooks.dart';
import 'ebooks_veiw.dart';

class ebooks_home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
                    // Navigator.pushNamed(context, '/upload');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UploadPage()
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        size: 80.0,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Upload',
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
                    // Navigator.pushNamed(context, '/view');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ebooks_veiw()
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.view_list,
                        size: 80.0,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'View',
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
