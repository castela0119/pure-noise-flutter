import 'package:audio_test/widgets/seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../models/position_data.dart';
// import 'seek_bar.dart';

class AudioSeekBar extends StatelessWidget {
  final AudioPlayer player;

  const AudioSeekBar({
    Key? key,
    required this.player,
  }) : super(key: key);

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: _positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        final duration = positionData?.duration ?? Duration.zero;
        final position = positionData?.position ?? Duration.zero;
        final buffered = positionData?.bufferedPosition ?? Duration.zero;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(position),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  _formatDuration(duration),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            SeekBar(
              duration: duration,
              position: position,
              bufferedPosition: buffered,
              onChangeEnd: player.seek,
            ),
          ],
        );
      },
    );
  }
}
