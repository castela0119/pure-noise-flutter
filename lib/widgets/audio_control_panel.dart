import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioControlPanel extends StatefulWidget {
  final AudioPlayer player;

  const AudioControlPanel({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  _AudioControlPanelState createState() => _AudioControlPanelState();
}

class _AudioControlPanelState extends State<AudioControlPanel> {
  bool isPlaying = false;
  bool isVolumeDisabled = false;
  double volume = 0.5;

  void _playPause() async {
    if (isPlaying) {
      await widget.player.pause();
    } else {
      await widget.player.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _toggleVolume() async {
    if (isVolumeDisabled) {
      await widget.player.setVolume(volume);
    } else {
      volume = widget.player.volume;
      await widget.player.setVolume(0);
    }
    setState(() {
      isVolumeDisabled = !isVolumeDisabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: _playPause,
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 50,
            color: Colors.blue,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: _toggleVolume,
              icon: Icon(
                isVolumeDisabled ? Icons.volume_off : Icons.volume_up_rounded,
                color: Colors.yellow,
              ),
            ),
            Expanded(
              child: Slider(
                value: widget.player.volume,
                max: 1.0,
                min: 0.0,
                onChanged: (value) async {
                  setState(() {
                    volume = value;
                  });
                  await widget.player.setVolume(value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
