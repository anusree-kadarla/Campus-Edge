import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';


class UploadImages extends StatefulWidget {
  @override
  uimages createState() => uimages();
}

class uimages extends State<UploadImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCard(context, 'Blood_donation_camps', '/Event_Image/Blood_donation_camps'),
          _buildCard(context, 'Ecficio', '/Event_Image/Ecficio'),
          _buildCard(context, 'Fest_full_of_rice', '/Event_Image/Fest_full_of_rice'),
          _buildCard(context, 'Nss', '/Event_Image/Nss'),
          _buildCard(context, 'Sintilationz', '/Event_Image/Sintilationz'),
          _buildCard(context, 'Turing_hut', '/Event_Image/Turing_hut'),
          _buildCard(context, 'VJTheatro', '/Event_Image/VJTheatro'),
          _buildCard(context, 'convergence', '/Event_Image/convergence'),
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
          _uploadImage(context, directory);
        },
      ),
    );
  }

  void _uploadImage(BuildContext context, String directory) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );

    if (result == null || result.files.isEmpty) return;

    PlatformFile file = result.files.first;
    File imageFile = File(file.path!);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('$directory/${imageFile.path.split('/').last}');
    UploadTask uploadTask = ref.putFile(imageFile);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Uploading Image'),
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
            content: Text('Your image was uploaded to $directory.'),
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
            content: Text('An error occurred while uploading your image.'),
          );
        },
      );
    });
  }
}