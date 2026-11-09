import 'package:flutter/material.dart';

void main() {
  runApp(ExerciseApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExerciseApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExerciseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dementia Exercise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 138, 182, 142),

        appBar: AppBar(
          title: const Text(
            'Exercise',
            style: TextStyle(
              color: Colors.white, // Change the color here
            ),
          ),
          backgroundColor: Color.fromARGB(255, 13, 61, 23),

        ),
        body: ExercisePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ExerciseCard(
          title: 'Chair Exercises',
          description: 'Simple exercises that can be done while sitting in a chair.',
          icon: Icons.event_seat,
          imagePaths: const [
            'assets/images/chair/chair_exercise_1.jpg',
            'assets/images/chair/chair_exercise_2.png',
            'assets/images/chair/chair_exercise_3.jpg',
            'assets/images/chair/chair_exercise_4.jpg',
            'assets/images/chair/chair_exercise_5.jpg',
            'assets/images/chair/chair_exercise_6.jpg',
          ],
          imagePath: '',
        ),
        ExerciseCard(
          title: 'Walking',
          description: 'Walking is a great way to stay active and engaged.',
          icon: Icons.directions_walk,
          imagePaths: const [
            'assets/images/walking/walking_0.png',
            'assets/gifs/walking_1.gif',  // New GIFs
            'assets/gifs/walking_2.gif',
            'assets/gifs/walking_3.gif',
            'assets/gifs/walking_4.gif',
          ],
          imagePath: '',
        ),
        ExerciseCard(
          title: 'Stretching',
          description: 'Gentle stretching helps improve flexibility and circulation.',
          icon: Icons.accessibility,
          imagePaths: const [
            'assets/images/stretching/stretching_0.jpg',
            'assets/images/stretching/stretching_1.png',
            'assets/images/stretching/stretching_2.png',
            'assets/images/stretching/stretching_3.png',
            'assets/images/stretching/stretching_4.png',
          ],
          imagePath: '',
        ),
      ],
    );
  }
}

class ExerciseCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String>? steps;
  final IconData icon;
  final List<String>? imagePaths;

  ExerciseCard({
    required this.title,
    required this.description,
    required this.icon,
    this.steps,
    this.imagePaths,
    required String imagePath,
  });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: ListTile(
          leading: Icon(widget.icon),
          title: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          subtitle: Text(
            widget.description,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        children: <Widget>[
          if (widget.steps != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.steps!.map((step) {
                  return Text(
                    '• $step',
                    style: TextStyle(fontSize: 20.0),
                  );
                }).toList(),
              ),
            ),
          if (widget.imagePaths != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: widget.imagePaths!.map((path) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: Image.asset(path),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Image.asset(
                      path,
                      width: 556,
                      height: 279,
                      fit: BoxFit.contain,
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

