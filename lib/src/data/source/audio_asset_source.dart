import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/services.dart';
import 'package:wav/wav.dart';

import 'wave_source.dart';

class AudioAssetSource extends WaveSource {
  final String path;

  AudioAssetSource({required this.path});

  @override
  Future<void> evaluate() async {

    // Load the asset data as bytes
    ByteData assetData = await rootBundle.load(path);
    // var numChannels = 1;

    // Write the PCM data to a temporary file
    String pcmPath = '${Directory.systemTemp.path}/input.pcm';
    File pcmFile = File(pcmPath);
    await pcmFile.writeAsBytes(assetData.buffer.asUint8List());

    // Use FFmpeg to convert the PCM file to a WAV file
    String wavPath = '${Directory.systemTemp.path}/output.wav';
    FFmpegKitConfig.enableLogCallback(null); // Disable logging
    FFmpegKitConfig.enableStatisticsCallback(null); // Disable statistics
    // FFmpegSession session = await FFmpegKit.executeAsync(
    //     '-f s16le -ar 44100 -ac $numChannels -i $pcmPath $wavPath',
    //     null);
    bool fileExist = await File(wavPath).exists();
    bool canGetWave = fileExist;

    if (!fileExist) {
      FFmpegSession session = await FFmpegKit.executeAsync(
          '-i $pcmPath -vn -acodec pcm_s16le -ar 44100 -ac 2 $wavPath');
      canGetWave = ReturnCode.isSuccess(await session.getReturnCode());
      if (!canGetWave) {
        throw "Error: ${await session.getLogsAsString()}";
      }
    }
    ///creating the wave
    if (canGetWave) {
      Wav wav = await Wav.readFile(wavPath);
      samples =  (wav.channels.toList())
          .expand((element) => element)
          .map((e) => e.toDouble())
          .toList();
    }
  }
}