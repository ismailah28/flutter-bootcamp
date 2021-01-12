import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  void playSound(int soundNumber) {
    final player = AudioCache();
    player.play('note$soundNumber.wav');
  }

  Expanded buildKey({Color color, int soundNote}) => Expanded(
        child: FlatButton(
          color: color,
          onPressed: () {
            playSound(soundNote);
          },
          child: Text('Click Me!'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildKey(color: Colors.red, soundNote: 1),
              buildKey(color: Colors.orange, soundNote: 2),
              buildKey(color: Colors.yellow, soundNote: 3),
              buildKey(color: Colors.green, soundNote: 4),
              buildKey(color: Colors.teal, soundNote: 5),
              buildKey(color: Colors.blue, soundNote: 6),
              buildKey(color: Colors.purple, soundNote: 7),
            ],
          ),
        ),
      ),
    );
  }
}
