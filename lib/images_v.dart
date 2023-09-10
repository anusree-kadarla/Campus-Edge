import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagesView extends StatefulWidget {
  const ImagesView({Key? key}) : super(key: key);
  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event images')),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index) {
          final directoryNames = [
            '/Event_Image/Sintilationz',
            '/Event_Image/Ecficio',
            '/Event_Image/Nss',
            '/Event_Image/Turing_hut',
            '/Event_Image/VJTheatro',
            '/Event_Image/convergence',
          ];
          final directoryTitles = [
            'Sintilationz',
            'Ecficio',
            'Nss',
            'Turing_hut',
            'VJTheatro',
            'convergence',
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
                      final List<Reference> images = result.items.where((item) => item.name.endsWith('.jpg') || item.name.endsWith('.jpeg') || item.name.endsWith('.png')).toList();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageScreen(images: images),
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


class ImageScreen extends StatelessWidget {
  final List<Reference> images;

  const ImageScreen({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Images')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 0.8,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: images.map((image) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: InkWell(
                onTap: () async {
                  final url = await image.getDownloadURL();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FullScreenImage(url: url),
                  ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FutureBuilder(
                    future: image.getDownloadURL(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.network(
                          snapshot.data.toString(),
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
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



class FullScreenImage extends StatelessWidget {
  final String url;

  const FullScreenImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: url,
            child: Image.network(
              url,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}

