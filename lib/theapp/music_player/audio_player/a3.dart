import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MusicApp3());
}

class MusicApp3 extends StatelessWidget {
  const MusicApp3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MusicPage3(),
    );
  }
}

class MusicPage3 extends StatefulWidget {
  const MusicPage3({Key? key}) : super(key: key);

  @override
  State<MusicPage3> createState() => _MusicPageState3();
}

class _MusicPageState3 extends State<MusicPage3> {
  bool isPlaying = false;//State to keep track of whether audio is playing
  double value = 0;// State to keep track of slider value
  final player = AudioPlayer(); // AudioPlayer instance for playing audio
  Duration? duration = Duration(seconds: 0);// State to keep track of audio duration


  void initPlayer() async {
    await player.setSource(AssetSource("Celin_dion.mp3"));  // Setting audio source
    duration = await player.getDuration();  //audio duration
    
  }

  @override
  void initState() {
    super.initState();
    initPlayer();// initialise the audio player when the widget is first created

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with blur effect
          Container(
            constraints: BoxConstraints.expand(),
            height: 300.0,
            width: 300.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Celin_dion.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter( //blur
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               // Album cover image
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  "assets/Celin_dion.jpg",// Background image
                  width: 250.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "My heart will go on and on", // Song title
                style: TextStyle(
                    color: Colors.white, fontSize: 36, letterSpacing: 6),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(  // Slider to display and control audio progress
                    "${(value / 60).floor()}: ${(value % 60).floor()}",
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(  
                    width: 260.0,
                    child: Slider.adaptive(
                      onChangeEnd: (new_value) async {
                        setState(() {
                          value = new_value;
                        });
                        player.pause();
                        await player.seek(Duration(seconds: new_value.toInt())); 
                        // seeking audio to the new position
                      },
                      min: 0.0,
                      value: value,
                      max: duration!.inSeconds.toDouble(),// nullable operator '!'
                      onChanged: (new_value) {
                        setState(() {
                          value = new_value;
                        });
                      },
                      activeColor: Colors.white,
                    ),
                  ),
                  Text(//display total audio duration
                    "${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.white38),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTap: () async {
                        int newPosition =
                            (value - 10).toInt().clamp(0, duration!.inSeconds); // Calculate new position after rewinding
                        await player.seek(Duration(seconds: newPosition)); // Seek audio to the new position
                        setState(() {
                          value = newPosition.toDouble();
                        });
                      },
                      child: Center(
                        child: Icon(
                          Icons.fast_rewind_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // Button to play/pause audio
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.pink),
                    ),
                    width: 60.0,
                    height: 60.0,
                    child: InkWell(
                      onTap: () async {
                        if (isPlaying) {
                          await player.pause(); // Pause audio if playing
                        } else {
                          await player.resume(); // Resume audio if paused
                          player.onPositionChanged.listen(
                            (Duration d) {
                              setState(() {
                                value = d.inSeconds.toDouble(); // Update slider value as audio plays
                              });
                            },
                          );
                        }
                        setState(() {
                          isPlaying = !isPlaying; // Toggle play/pause state
                        });
                      },
                      child: Center(
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.white38),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTap: () async {
                        // Calculate new position after fast forwardin
                        int newPosition =
                            (value + 10).toInt().clamp(0, duration!.inSeconds); 
                        await player.seek(Duration(seconds: newPosition));
                        setState(() {
                          value = newPosition.toDouble();
                        });
                      },
                      child: Center(
                        child: Icon(
                          Icons.fast_forward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
