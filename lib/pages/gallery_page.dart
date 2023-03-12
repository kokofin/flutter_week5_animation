import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);


@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          title: const Text('Anime Gallery'),
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(18.0),
            itemCount: 400,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 18.0,
              crossAxisSpacing: 18.0,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  debugPrint(
                      "LOG_ONTAP https://source.unsplash.com/random/300x300?anime=$index");

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DetailImagePage(
                        urlImage:
                        "https://source.unsplash.com/random/300x300?anime=$index",
                        size: '300 x 300 $index',
                      )));
                },
                child: Image.network(
                  "https://source.unsplash.com/random/300x300?anime=$index&sig=${DateTime.now().millisecondsSinceEpoch}",
                  frameBuilder: (BuildContext context, Widget child, int? frame, bool? wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded ?? false) {
                      return child;
                    }
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: frame != null ? child : const CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, object, error) {
                    return const Icon(Icons.error);
                  },
                ),
              );
            }));
  }
}


class DetailImagePage extends StatelessWidget {
  final String urlImage;
  final String size;

  const DetailImagePage({Key? key, required this.urlImage, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(urlImage, fit: BoxFit.cover, width: 320, height: 280),
            Text(size)
          ],
        ),

        /// Contoh Full Screen Size
        // Image.network(urlImage,
        //   fit: BoxFit.cover,
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height),
      ),
    );
  }
}
