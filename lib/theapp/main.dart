import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'meditation/main.dart' as meditation;
import 'memory_game/main.dart' as memory_game;
import 'todolist/main.dart' as todolist;
import 'exercise/main.dart' as exercise;
import 'music_player/main.dart' as music_player;
import 'package:firebase_core/firebase_core.dart';
import 'package:rm/theapp/firebase_options.dart';
import 'package:rm/main.dart'; // Import MyApp from your main file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyDementiaApp());
}

class MyDementiaApp extends StatelessWidget {
  const MyDementiaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 13, 61, 23),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sign Out"),
          content: Text("Are you sure you want to sign out?"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await FirebaseAuth.instance.signOut();
                // Navigate back to the login page after logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 182, 142),
      appBar: AppBar(
        title: const Text(
          'RememberWell',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () => _signOut(context),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryTile(
                    context,
                    'Exercise',
                    Icons.directions_run,
                    const Color.fromARGB(255, 3, 62, 165),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => exercise.MyApp()),
                      );
                    },
                  ),
                  _buildCategoryTile(
                    context,
                    'To-Do List',
                    Icons.checklist,
                    Colors.black,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => todolist.MyApp()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryTile(
                    context,
                    'Meditation',
                    Icons.spa,
                    Colors.purple,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => meditation.MyApp()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryTile(
                    context,
                    'Music',
                    Icons.music_note,
                    Colors.orange,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => music_player.MyApp()),
                      );
                    },
                  ),
                  _buildCategoryTile(
                    context,
                    'Games',
                    Icons.videogame_asset,
                    Colors.red,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => memory_game.MyApp()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTile(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
