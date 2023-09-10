import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class UploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ebooks'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCard(context, 'SEM 1-1', '/Ebooks/SEM 1-1'),
          _buildCard(context, 'SEM 1-2', '/Ebooks/SEM 1-2'),
          _buildCard(context, 'SEM 2-1', '/Ebooks/SEM 2-1'),
          _buildCard(context, 'SEM 2-2', '/Ebooks/SEM 2-2'),
          _buildCard(context, 'SEM 3-1', '/Ebooks/SEM 3-1'),
          _buildCard(context, 'SEM 3-2', '/Ebooks/SEM 3-2'),
          _buildCard(context, 'SEM 4-1', '/Ebooks/SEM 4-1'),
          _buildCard(context, 'SEM 4-2', '/Ebooks/SEM 4-2'),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String directory) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.file_upload),
        title: Text(title),
        onTap: () {
          _uploadPDF(context, directory);
        },
      ),
    );
  }

  void _uploadPDF(BuildContext context, String directory) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null || result.files.isEmpty) return;

    PlatformFile file = result.files.first;
    File pdfFile = File(file.path!);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('$directory/${pdfFile.path
        .split('/')
        .last}');
    UploadTask uploadTask = ref.putFile(pdfFile);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Uploading PDF'),
          content: StreamBuilder<TaskSnapshot>(
            stream: uploadTask.snapshotEvents,
            builder: (context, snapshot) {
              var progress = 0.0;
              if (snapshot.hasData) {
                var taskSnapshot = snapshot.data!;
                progress =
                    taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
              }

              return LinearProgressIndicator(
                value: progress,
              );
            },
          ),
        );
      },
    );

    uploadTask.then((res) {
      Navigator.of(context).pop(); // Close the progress dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Successful'),
            content: Text('Your PDF was uploaded to $directory.'),
          );
        },
      );
    }).catchError((err) {
      Navigator.of(context).pop(); // Close the progress dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Failed'),
            content: Text('An error occurred while uploading your PDF.'),
          );
        },
      );
    });
  }
}
