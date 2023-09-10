import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class ebooks_veiw extends StatefulWidget {
  const ebooks_veiw({Key? key}) : super(key: key);
  @override
  veiw createState() => veiw();
}

class veiw extends State<ebooks_veiw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ebooks')),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(8, (index) {
          final directoryNames = [
            '/Ebooks/SEM 1-1',
            '/Ebooks/SEM 1-2',
            '/Ebooks/SEM 2-1',
            '/Ebooks/SEM 2-2',
            '/Ebooks/SEM 3-1',
            '/Ebooks/SEM 3-2',
            '/Ebooks/SEM 4-1',
            '/Ebooks/SEM 4-2',
          ];
          final directoryTitles = [
            'SEM 1-1',
            'SEM 1-2',
            'SEM 2-1',
            'SEM 2-2',
            'SEM 3-1',
            'SEM 3-2',
            'SEM 4-1',
            'SEM 4-2',
          ];
          final directoryName = directoryNames[index];
          return Card(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                bool _isPressed = false;
                return InkWell(
                  onTap: () async {
                    if (!_isPressed) {
                      setState(() {
                        _isPressed = true;
                      });
                      final directory = FirebaseStorage.instance.ref().child(directoryName);
                      final ListResult result = await directory.listAll();
                      final List<Reference> pdfs = result.items.where((item) => item.name.endsWith('.pdf')).toList();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PdfScreen(pdfs: pdfs),
                      ));
                    }
                  },
                  child: Center(
                    child: Text(
                      directoryTitles[index],
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}

class PdfScreen extends StatelessWidget {
  final List<Reference> pdfs;

  const PdfScreen({Key? key, required this.pdfs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDFs')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 0.8,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: pdfs.map((pdf) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: InkWell(
                onTap: () async {
                  final url = await pdf.getDownloadURL();
                  final fileName = pdf.name;
                  await _downloadPdf(context, url, fileName);
                },
                child: Center(
                  child: Text(
                    pdf.name,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

Future<void> _downloadPdf(BuildContext context, String url, String fileName) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$fileName');
  final request = await HttpClient().getUrl(Uri.parse(url));
  final response = await request.close();
  await response.pipe(file.openWrite());

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('$fileName downloaded'),
  ));
}

