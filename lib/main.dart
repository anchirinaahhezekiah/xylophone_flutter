import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle to load assets

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();

  // Method to play sound from assets
  Future<void> playSound(int soundNumber) async {
    try {
      final ByteData data = await rootBundle
          .load('assets/note$soundNumber.wav'); // Load audio file
      final bytes = data.buffer.asUint8List(); // Convert to byte array
      await player.play(BytesSource(bytes)); // Play audio using BytesSource
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  Expanded buildKey({required Color color, required int soundNumber}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: color),
        onPressed: () {
          playSound(soundNumber); // Play the corresponding note
        },
        child: const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKey(color: Colors.red, soundNumber: 1),
              buildKey(color: Colors.orange, soundNumber: 2),
              buildKey(color: Colors.yellow, soundNumber: 3),
              buildKey(color: Colors.green, soundNumber: 4),
              buildKey(color: Colors.teal, soundNumber: 5),
              buildKey(color: Colors.blue, soundNumber: 6),
              buildKey(color: Colors.purple, soundNumber: 7),
            ],
          ),
        ),
      ),
    );
  }
}
