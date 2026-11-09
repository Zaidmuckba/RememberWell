import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'a1.dart';
import 'a2.dart';
import 'a3.dart';

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
      home: ImageLayout(),
    );
  }
}

class ImageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 182, 142),

      appBar: AppBar(
        title: const Text(
          'Audio',
          style: TextStyle(
            color: Colors.white, // Change the color here
          ),
        ),
        backgroundColor: Color.fromARGB(255, 13, 61, 23),

      ),
      body: Container(
        color: Color.fromARGB(255, 138, 182, 142),

        child: SingleChildScrollView(
 // Background color of the page
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 120,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MusicPage1()),
                );
              },
              child: ImageWithTitle(
                image: AssetImage('assets/country_roads.jpg'),
                title: 'John Denver - Country Roads ',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MusicPage2()),
                );
              },
              child: ImageWithTitle(
                image: AssetImage('assets/BackstreetBoys.jpg'),
                title: ' BackStreet Boys - I Want It That Way ',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MusicPage3()),
                );
              },
              child: ImageWithTitle(
                image: AssetImage('assets/Celin_dion.jpg'),
                title: 'Celin Dion - My Heart Will Go On and On',
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}

//weve definwed a class image title , with custom image adjustments
class ImageWithTitle extends StatelessWidget {
  final ImageProvider image;
  final String title;

  const ImageWithTitle({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
