import 'dart:io';
import 'dart:typed_data';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/services.dart';
import 'package:wav/wav.dart';

abstract class WaveSource {
  List<double> _samples = [];

  Future<List<double>> get samples async => _samples;
}

class AudioAssetSource extends WaveSource {
  final String path;

  AudioAssetSource({required this.path});

  @override
  Future<List<double>> get samples async {
    // Load the asset data as bytes
    ByteData assetData = await rootBundle.load(path);
    var numChannels = 1;

    // Write the PCM data to a temporary file
    String pcmPath = '${Directory.systemTemp.path}/input.pcm';
    File pcmFile = File(pcmPath);
    await pcmFile.writeAsBytes(assetData.buffer.asUint8List());

    // Use FFmpeg to convert the PCM file to a WAV file
    String wavPath = '${Directory.systemTemp.path}/output.wav';
    FFmpegKitConfig.enableLogCallback(null); // Disable logging
    FFmpegKitConfig.enableStatisticsCallback(null); // Disable statistics
    FFmpegSession session = await FFmpegKit.executeAsync(
        '-f s16le -ar 44100 -ac $numChannels -i $pcmPath $wavPath',
        null);
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
      _samples =  (wav.channels.toList())
          .expand((element) => element)
          .map((e) => e.toDouble())
          .toList();
    }
    return _samples;
  }
}

class AudioFileSource extends WaveSource {
  final String path;

  AudioFileSource({required this.path});

  @override
  Future<List<double>> get samples async {
    String wavPath = path.replaceRange(path.length - 3, path.length, "wav");
    bool fileExist = await File(wavPath).exists();
    bool canGetWave = fileExist;

    if (!fileExist) {
      FFmpegSession session = await FFmpegKit.executeAsync(
          '-i $path -vn -acodec pcm_s16le -ar 44100 -ac 2 $wavPath');
      canGetWave = ReturnCode.isSuccess(await session.getReturnCode());
      if (!canGetWave) {
        throw "Error: ${await session.getLogsAsString()}";
      }
    }

    ///creating the wave
    if (canGetWave) {
      Wav wav = await Wav.readFile(wavPath);
      _samples = (wav.channels.toList())
          .expand((element) => element)
          .map((e) => e.toDouble())
          .toList();
    }
    // Delete the temporary file
    File(wavPath).deleteSync();
    return _samples;
  }
}

class AudioNetworkSource extends WaveSource {
  final String path;

  AudioNetworkSource({required this.path});

  @override
  Future<List<double>> get samples async {
    _samples = [];

    return _samples;
  }
}

class AudioDateSource extends WaveSource {
  @override
  Future<List<double>> get samples async {
    return _samples;
  }

  AudioDateSource(List<double> samples) {
    _samples = samples;
  }
}
