import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: redwine(),
    );
  }
}*/

class redwine extends StatefulWidget {
  const redwine({Key? key}) : super(key: key);

  @override
  State<redwine> createState() => _redwine();
}

class _redwine extends State<redwine> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/redredwine.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  //used to realease resources held by video player controller(maintains efficiency n integrity)
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Red Red Wine',
          style: TextStyle(
            color: Colors.white, // Change the color here
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white, // Set the color to white
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 13, 61, 23),

      ),
      backgroundColor: Color.fromARGB(255, 138, 182, 142),

      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Stack(
        children: [
          /*Positioned(
            top:70.0,
            left: 20.0,
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 37, 13, 121),
              foregroundColor: Colors.white,
              child: const Icon(Icons.arrow_back),

              onPressed:(){
              //code for back


            }
            ),
            ),*/
          Positioned(
            bottom:10.0,
            right:MediaQuery.of(context).size.width/ 2 - 50,
            child:FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 13, 61, 23),

              foregroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            ),
        ],
      ),
    );
  }
}
