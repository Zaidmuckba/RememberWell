import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WordFormationGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WordFormationGame extends StatefulWidget {
  @override
  _WordFormationGameState createState() => _WordFormationGameState();
}

class _WordFormationGameState extends State<WordFormationGame> {
  List<String> letters = [];
  List<String> validWords = [
    'cat',
    'dog',
    'bat',
    'hat',
    'mat',
    'act',
    'tab',
    'god',
    'watch',
    'clock',
    'food',
    'water',
    'drink',
    'health',
    'stick',
    'wood',
    'memory',
    'mind',
    'doctor',
    'ticks'
  ]; // Add more words as needed
  TextEditingController inputController = TextEditingController();
  int score = 0;
  int timerSeconds = 60;
  bool isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    // Generate a random set of letters matching a valid word
    generateRandomLetters();
    // Reset game variables
    score = 0;
    timerSeconds = 60;
    isTimerRunning = true;
    // Start the game timer
    startTimer();
  }

  void generateRandomLetters() {
    // Choose a random word from the validWords list
    final random = Random();
    String randomWord = validWords[random.nextInt(validWords.length)];

    // Convert the word to a list of characters and shuffle it
    List<String> shuffledLetters = randomWord.split('')..shuffle(random);

    setState(() {
      letters = shuffledLetters;
    });
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds > 0 && isTimerRunning) {
        setState(() {
          timerSeconds--;
        });
      } else {
        timer.cancel();
        isTimerRunning = false;
        showGameOverDialog();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your score: $score'),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
              child: Text('Play Again'),
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
          'Word Game',
          style: TextStyle(
            color: Colors.white, // Change the color here
          ),
        ),
        backgroundColor: Color.fromARGB(255, 13, 61, 23),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Time Remaining: $timerSeconds seconds',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Form words using these letters:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                letters.join(' '),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: inputController,
                decoration: InputDecoration(
                  labelText: 'Enter a word',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  checkWord();
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkWord() {
    String enteredWord = inputController.text.toLowerCase();

    if (validWords.contains(enteredWord) &&
        letters.any((letter) => enteredWord.contains(letter))) {
      setState(() {
        score += enteredWord.length;
        inputController.clear();
        generateRandomLetters();
      });
    } else {
      // Invalid word, show a message or perform some action
      print('Invalid word');
      score -= enteredWord.length;
    }
  }
}
