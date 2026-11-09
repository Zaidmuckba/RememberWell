import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MemoryGame(),
      debugShowCheckedModeBanner: false,

    );
  }
}

class MemoryGame extends StatefulWidget {
  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  List<String> images = [
    'assets/circle.png',
    'assets/heart.png',
    'assets/star.png',
    'assets/triangle.png',
  ];

  late List<String> cards;
  late List<bool> cardFlips;
  int? previousIndex;
  bool isAnimating = false;
  int pairsFound = 0;

  @override
  void initState() {
    super.initState();
    resetGame();
    revealCards();

  
  }

  Future<void> revealCards() async {
    // Reveal cards temporarily
    setState(() {
      cardFlips = List.filled(cards.length, true);
    });

    // Delay for 2 seconds
    await Future.delayed(const Duration(seconds: 4));

    // Reset the game after 2 seconds by flipping the cards back
    setState(() {
      cardFlips = List.filled(cards.length, false);
    });
  }

  void resetGame() {
    cards = List.from(images)..addAll(images);
    cards.shuffle();
    cardFlips = List.filled(cards.length, false);
    previousIndex = null;
    isAnimating = false;
    pairsFound = 0;
    revealCards();
  }

  void _onCardTap(int index) {
    if (isAnimating || cardFlips[index]!) return;

    setState(() {
      cardFlips[index] = true;

      if (previousIndex != null) {
        isAnimating = true;
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (cards[previousIndex!] == cards[index]) {
            pairsFound++;
            if (pairsFound == images.length) {
              _showGameEndDialog();
            }
          } else {
            cardFlips[previousIndex!] = false;
            cardFlips[index] = false;
          }
          isAnimating = false;
          previousIndex = null;
        });
      } else {
        previousIndex = index;
      }
    });
  }

  void _showGameEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have found all the pairs.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame(); // Reset the game when "Play Again" is pressed
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
          'Flip Game',
          style: TextStyle(
            color: Colors.white, // Change the color here
          ),
        ),
        backgroundColor: Color.fromARGB(255, 13, 61, 23),

      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _onCardTap(index);
            },
            child: SingleChildScrollView(
            child: Card(
              child: Center(
                child: cardFlips[index]!
                    ? Image.asset(cards[index])
                    : Image.asset('assets/hidden1.jpg'),
              ),
            ),
          ),);
        },
      ),
    );
  }
}
