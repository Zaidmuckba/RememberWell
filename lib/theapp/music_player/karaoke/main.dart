import 'package:flutter/material.dart';
import 'package:rm/theapp/music_player/karaoke/dancingqueen.dart';
import 'package:rm/theapp/music_player/karaoke/fallinginlove.dart';
import 'package:rm/theapp/music_player/karaoke/redredwine.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Karaoke(),
    );
  }
}

class Karaoke extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 182, 142),

      appBar: AppBar(
        title: const Text(
          'Karaoke',
          style: TextStyle(
            color: Colors.white, // Change the color here
          ),
        ),
        backgroundColor: Color.fromARGB(255, 13, 61, 23),

      ),
      body: Container(
        color: Color.fromARGB(255, 138, 182, 142),

        child: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 120,),
            ImageWithTitle(
              image: AssetImage('assets/queen1.jpg'),
              title: 'ABBA - Dancing Queen',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const dancingqueen()),
                );
              },
            ),
            ImageWithTitle(
              image: AssetImage('assets/falling.jpg'),
              title: 'Elvis Presley - I Can\'t Help Falling In Love',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const fallinglove()),
                );
              },
            ),
            ImageWithTitle(
              image: AssetImage('assets/redwine.jpg'),
              title: 'UB40 - Red Red Wine',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const redwine()),
                );
              },
            ),
          ],
        ),
      ),
    ),);
  }
}

class ImageWithTitle extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final VoidCallback onTap;

  const ImageWithTitle({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String title;

  const DetailsPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Details Page Placeholder',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
