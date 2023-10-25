import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:wav/wav.dart';

import 'wave_source.dart';

class AudioFileSource extends WaveSource {
  final String path;

  AudioFileSource({required this.path});

  @override
  Future<List<double>> evaluate() async {
    String wavPath = path.replaceRange(path.length - 3, path.length, "wav");
    bool fileExist = await File(wavPath).exists();
    bool canGetWave = fileExist;

    if (!fileExist) {
      FFmpegSession session = await FFmpegKit.executeAsync(
          '-y -i $path -vn -acodec pcm_s16le -ar 44100 -ac 2 $wavPath');
      canGetWave = ReturnCode.isSuccess(await session.getReturnCode());
      if (!canGetWave) {
        throw "Error: ${await session.getLogsAsString()}";
      }
    }

    ///creating the wave
    if (canGetWave) {
      Wav wav = await Wav.readFile(wavPath);
      samples = (wav.channels.toList())
          .expand((element) => element)
          .map((e) => e.toDouble())
          .toList();
    }
    // Delete the temporary file
    File(wavPath).deleteSync();
    return samples;
  }
}
