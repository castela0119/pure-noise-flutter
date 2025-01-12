import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../widgets/audio_control_panel.dart';
import '../widgets/audio_seek_bar.dart';

class JustAudioExample extends StatefulWidget {
  const JustAudioExample({super.key});

  @override
  State<JustAudioExample> createState() => _JustAudioExampleState();
}

class _JustAudioExampleState extends State<JustAudioExample> {
  final String imgUrl =
      'https://firebasestorage.googleapis.com/v0/b/new-ml-6c02d.appspot.com/o/lessonAssets%2Fcs3%2Fch7%2Fls4%2Fearth.jpeg?alt=media&token=b9ce6139-5e08-495d-b74f-9dfce09e86e2';
  final String url =
      'https://files.freemusicarchive.org//storage-freemusicarchive-org//tracks//CAsMyXsiK0RkmsBG2K75J4wdewYDJElKJCe1tSQM.mp3';

  late final AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setUrl(url);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Just Audio Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imgUrl,
            height: 200,
            width: 300,
          ),
          const SizedBox(
            height: 16,
          ),
          AudioControlPanel(
            player: player,
          ),
          const SizedBox(
            height: 16,
          ),
          AudioSeekBar(
            player: player,
          ),
        ],
      ),
    );
  }
}
